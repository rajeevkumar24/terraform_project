resource "azuread_group" "engineering" {
    display_name = "Education department"
    security_enabled = true  
}

resource "azuread_group_member" "it" {

    for_each = {for user in azureadazuread_user.users: user.first_name => user if user.department == "Education"}
    group_object_id = azuread_group.engineering.id
    member_object_id = each.value.id
  
}