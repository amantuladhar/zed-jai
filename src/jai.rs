use std::fs;
use zed::{LanguageServerId, Worktree};
use zed_extension_api::{self as zed, Result, serde_json, settings::LspSettings};

struct JaiExtension {
    cached_binary_path: Option<String>,
}

impl JaiExtension {
    fn language_server_binary_path(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<String> {
        let language_server = language_server_id.as_ref();
        if let Some(path) = LspSettings::for_worktree(language_server, worktree)
            .ok()
            .and_then(|settings| settings.binary)
            .and_then(|binary| binary.path)
        {
            return Ok(path);
        }

        if let Some(path) = worktree.which(language_server) {
            self.cached_binary_path = Some(path.clone());
            return Ok(path);
        }

        if let Some(path) = &self.cached_binary_path {
            if fs::metadata(path).map_or(false, |stat| stat.is_file()) {
                return Ok(path.to_string());
            }
        }

        Err("Unable to locate jails binary".to_string())
    }
}

impl zed::Extension for JaiExtension {
    fn new() -> Self {
        Self {
            cached_binary_path: None,
        }
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<zed::Command> {
        let jails_binary_path = self.language_server_binary_path(language_server_id, worktree)?;
        Ok(zed::Command {
            command: jails_binary_path,
            // args: vec!["-verbose".to_string()],
            args: Default::default(),
            env: Default::default(),
        })
    }

    fn language_server_workspace_configuration(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<Option<serde_json::Value>> {
        let settings = LspSettings::for_worktree(language_server_id.as_ref(), worktree)
            .ok()
            .and_then(|lsp_settings| lsp_settings.settings.clone())
            .unwrap_or_default();
        Ok(Some(settings))
    }
}

zed::register_extension!(JaiExtension);
