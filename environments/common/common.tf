terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-iac"
    storage_account_name = "stiac001"
    container_name       = "tfstate"
    key                  = "common.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# aionbyte resource group
resource "azurerm_resource_group" "aionbyte" {
  name     = "rg-aionbyte"
  location = "centralus"
  tags = {
    project = "crossborder"
  }
}

# aionbyte.com
resource "azurerm_dns_zone" "aionbyte_com" {
  name                = "aionbyte.com"
  resource_group_name = azurerm_resource_group.aionbyte.name
  tags = {
    project = "crossborder"
  }
}

resource "azurerm_dns_ns_record" "api-dev_aionbyte_com" {
  name                = "api-dev"
  zone_name           = azurerm_dns_zone.aionbyte_com.name
  resource_group_name = azurerm_resource_group.aionbyte.name
  ttl                 = 3600

  records = azurerm_dns_zone.api-dev_aionbyte_com.name_servers

  tags = {
    project = "crossborder"
  }
}

resource "azurerm_dns_ns_record" "web-dev_aionbyte_com" {
  name                = "web-dev"
  zone_name           = azurerm_dns_zone.aionbyte_com.name
  resource_group_name = azurerm_resource_group.aionbyte.name
  ttl                 = 3600

  records = azurerm_dns_zone.web-dev_aionbyte_com.name_servers

  tags = {
    project = "crossborder"
  }
}

# aionbyte.com child
# api-dev.aionbyte.com
resource "azurerm_dns_zone" "api-dev_aionbyte_com" {
  name                = "api-dev.aionbyte.com"
  resource_group_name = azurerm_resource_group.aionbyte.name
  tags = {
    project = "crossborder"
  }
}

# resource "azurerm_dns_ns_record" "api-dev_aionbyte_com_parent_ns" {
#   name                = "@"
#   zone_name           = azurerm_dns_zone.api-dev_aionbyte_com.name
#   resource_group_name = azurerm_resource_group.aionbyte.name
#   ttl                 = 172800

#   records = azurerm_dns_zone.aionbyte_com.name_servers

#   tags = {
#     project = "crossborder"
#   }
# }

# aionbyte.com child
# web-dev.aionbyte.com
resource "azurerm_dns_zone" "web-dev_aionbyte_com" {
  name                = "web-dev.aionbyte.com"
  resource_group_name = azurerm_resource_group.aionbyte.name
  tags = {
    project = "crossborder"
  }
}

# resource "azurerm_dns_ns_record" "web-dev_aionbyte_com_parent_ns" {
#   name                = "@"
#   zone_name           = azurerm_dns_zone.web-dev_aionbyte_com.name
#   resource_group_name = azurerm_resource_group.aionbyte.name
#   ttl                 = 172800

#   records = azurerm_dns_zone.aionbyte_com.name_servers

#   tags = {
#     project = "crossborder"
#   }
# }

# e2way resource group
resource "azurerm_resource_group" "e2way" {
  name     = "rg-e2way"
  location = "centralus"
  tags = {
    project = "crossborder"
  }
}

# e2way.co
resource "azurerm_dns_zone" "e2way_co" {
  name                = "e2way.co"
  resource_group_name = azurerm_resource_group.e2way.name
  tags = {
    project = "crossborder"
  }
}


resource "azurerm_dns_ns_record" "api-dev_e2way_co" {
  name                = "api-dev"
  zone_name           = azurerm_dns_zone.e2way_co.name
  resource_group_name = azurerm_resource_group.e2way.name
  ttl                 = 3600

  records = azurerm_dns_zone.api-dev_e2way_co.name_servers

  tags = {
    project = "crossborder"
  }
}

resource "azurerm_dns_ns_record" "web-dev_e2way_co" {
  name                = "web-dev"
  zone_name           = azurerm_dns_zone.e2way_co.name
  resource_group_name = azurerm_resource_group.e2way.name
  ttl                 = 3600

  records = azurerm_dns_zone.web-dev_e2way_co.name_servers

  tags = {
    project = "crossborder"
  }
}

# e2way.co child
# api-dev.e2way.co
resource "azurerm_dns_zone" "api-dev_e2way_co" {
  name                = "api-dev.e2way.com"
  resource_group_name = azurerm_resource_group.e2way.name
  tags = {
    project = "crossborder"
  }
}

# resource "azurerm_dns_ns_record" "api-dev_e2way_co_parent_ns" {
#   name                = "@"
#   zone_name           = azurerm_dns_zone.api-dev_e2way_co.name
#   resource_group_name = azurerm_resource_group.e2way.name
#   ttl                 = 172800

#   records = azurerm_dns_zone.e2way_co.name_servers

#   tags = {
#     project = "crossborder"
#   }
# }

# e2way.co child
# web-dev.e2way.co
resource "azurerm_dns_zone" "web-dev_e2way_co" {
  name                = "web-dev.e2way.com"
  resource_group_name = azurerm_resource_group.e2way.name
  tags = {
    project = "crossborder"
  }
}

# resource "azurerm_dns_ns_record" "web-dev_e2way_co_parent_ns" {
#   name                = "@"
#   zone_name           = azurerm_dns_zone.web-dev_e2way_co.name
#   resource_group_name = azurerm_resource_group.e2way.name
#   ttl                 = 172800

#   records = azurerm_dns_zone.e2way_co.name_servers

#   tags = {
#     project = "crossborder"
#   }
# }