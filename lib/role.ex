defmodule RolePostgres do
	def role(_tags \\ []) do
		%{
			desired_packages: [
				"postgresql",
				"postgresql-contrib", # for auto_explain module
				"pgtop",
				# For making backups
				"bzip2",
				"xz-utils",
				"zstd",
			],
			ssh_allow_users: ["postgres"],
			ferm_output_chain:
				"""
				# User may not exist yet
				@def $user_postgres = `(getent passwd postgres > /dev/null && echo postgres) || echo root`;

				outerface lo {
					# PostgreSQL does stats collection on a random UDP port
					proto udp daddr 127.0.0.1 mod owner uid-owner $user_postgres ACCEPT;
				}
				"""
		}
	end
end
