defmodule RolePostgres do
	def role(_tags \\ []) do
		%{
			desired_packages: [
				"postgresql",
				# For making backups
				"bzip2",
				"xz-utils",
			],
			ssh_allow_users: ["postgres"],
			ferm_output_chain:
				"""
				outerface lo {
					# PostgreSQL does stats collection on a random UDP port
					proto udp daddr 127.0.0.1 mod owner uid-owner postgres ACCEPT;
				}
				"""
		}
	end
end
