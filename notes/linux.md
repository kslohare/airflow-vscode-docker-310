### to print folder structure
```
tree -L 3
```

### aliase for airlfow
```
alias af='airflow'
af version

```

### systemctl is the command-line tool for controlling systemd, the service and system manager used in most modern Linux distributions (including Ubuntu).

**systemd**:    The init system managing services and resources

**systemctl**:	The command to control systemd

In simple terms:
systemctl lets you start, stop, enable, disable, check, and inspect system services and units (like docker, nginx, postgresql, etc.).

Common systemctl commands

```
| Command                                    | What it does                                  | Example                             |
| ------------------------------------------ | --------------------------------------------- | ----------------------------------- |
| `systemctl start <service>`                | Start a service immediately                   | `sudo systemctl start docker`       |
| `systemctl stop <service>`                 | Stop a service                                | `sudo systemctl stop apache2`       |
| `systemctl restart <service>`              | Restart a service                             | `sudo systemctl restart postgresql` |
| `systemctl reload <service>`               | Reload configuration without full restart     | `sudo systemctl reload nginx`       |
| `systemctl status <service>`               | Show running status and logs                  | `systemctl status docker`           |
| `systemctl enable <service>`               | Enable service to start automatically on boot | `sudo systemctl enable docker`      |
| `systemctl disable <service>`              | Disable automatic startup                     | `sudo systemctl disable docker`     |
| `systemctl list-units --type=service`      | List all running services                     |                                     |
| `systemctl list-unit-files --type=service` | List all installed service unit files         |                                     |
| `systemctl is-active <service>`            | Check if service is running                   | `systemctl is-active ssh`           |
| `systemctl is-enabled <service>`           | Check if service is enabled on boot           | `systemctl is-enabled docker`       |

```


