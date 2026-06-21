data "http" "hetzner_ccm_release" {
  count = var.hetzner_ccm_version == null ? 1 : 0
  url   = "https://api.github.com/repos/hetznercloud/hcloud-cloud-controller-manager/releases/latest"

  request_headers = {
    Accept = "application/vnd.github+json"
  }
}

data "http" "hetzner_csi_release" {
  count = var.hetzner_csi_version == null && !var.disable_hetzner_csi ? 1 : 0
  url   = "https://api.github.com/repos/hetznercloud/csi-driver/releases/latest"

  request_headers = {
    Accept = "application/vnd.github+json"
  }
}

data "http" "kured_release" {
  count = var.kured_version == null ? 1 : 0
  url   = "https://api.github.com/repos/kubereboot/kured/releases/latest"

  request_headers = {
    Accept = "application/vnd.github+json"
  }
}

data "http" "kured_manifest" {
  url = "https://github.com/kubereboot/kured/releases/download/${local.kured_version}/kured-${local.kured_version}-${local.kured_yaml_suffix}.yaml"
}

data "http" "system_upgrade_controller_manifest" {
  url = "https://github.com/rancher/system-upgrade-controller/releases/download/${var.sys_upgrade_controller_version}/system-upgrade-controller.yaml"
}

data "http" "system_upgrade_controller_crd_manifest" {
  url = "https://github.com/rancher/system-upgrade-controller/releases/download/${var.sys_upgrade_controller_version}/crd.yaml"
}

data "http" "ccm_networks_manifest" {
  count = var.hetzner_ccm_use_helm ? 0 : 1
  url   = "https://github.com/hetznercloud/hcloud-cloud-controller-manager/releases/download/${local.ccm_version}/ccm-networks.yaml"
}

data "http" "calico_release" {
  count = var.calico_version == null && var.cni_plugin == "calico" ? 1 : 0
  url   = "https://api.github.com/repos/projectcalico/calico/releases/latest"

  request_headers = {
    Accept = "application/vnd.github+json"
  }
}

data "hcloud_ssh_keys" "keys_by_selector" {
  count         = length(var.ssh_hcloud_key_label) > 0 ? 1 : 0
  with_selector = var.ssh_hcloud_key_label
}
