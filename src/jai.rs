use std::fs;
use zed::{LanguageServerId, Worktree};
use zed_extension_api::{self as zed, Result, serde_json, settings::LspSettings};

struct JaiExtension {}

impl JaiExtension {
    fn language_server_binary_path(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<String> {
        Ok("/dev/null".to_string())
    }
}

impl zed::Extension for JaiExtension {
    fn new() -> Self {
        Self {}
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<zed::Command> {
        Ok(zed::Command {
            command: "/dev/null".to_string(),
            args: Default::default(),
            env: Default::default(),
        })
    }

    fn language_server_workspace_configuration(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<Option<serde_json::Value>> {
        Ok(None)
    }
}

zed::register_extension!(JaiExtension);
