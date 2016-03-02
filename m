From: Loic Dachary <loic@dachary.org>
Subject: installing paddles via ansible
Date: Wed, 2 Mar 2016 19:09:29 +0700
Message-ID: <56D6D7F9.4010104@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37009 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbcCBMJi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 07:09:38 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Thierry Delamare <t.delamare@laposte.net>

Hi Zack,

I'm running ansible to deploy paddles as follows. I am missing secrets.=
 But I have no secrets :-) This is just a standalone instance for tests=
, what would be the minimal way to define the secrets paddle needs ?

Thanks in advance for your help !

$ cat host
[paddles]
167.114.243.17
[paddles:vars]
ansible_ssh_user=3Dubuntu
ansible_ssh_keys=3D/home/loic/.ssh/id_rsa

(virtualenv)loic@fold:~/software/ceph/ceph-cm-ansible$ ansible-playbook=
 -i host paddles.yml=20

PLAY ******************************************************************=
*********

TASK [setup] **********************************************************=
*********
ok: [167.114.243.17]

TASK [users : Merge extra_admin_users into managed_admin_users] *******=
*********
skipping: [167.114.243.17]

TASK [users : Remove managed_admin_users from managed_users] **********=
*********
skipping: [167.114.243.17]

TASK [users : Filter the managed_users list] **************************=
*********
skipping: [167.114.243.17]

TASK [users : Filter the managed_admin_users list] ********************=
*********
skipping: [167.114.243.17]

TASK [users : Create all admin users with sudo access.] ***************=
*********
[DEPRECATION WARNING]: Using bare variables is deprecated. Update your=20
playbooks so that the environment value uses the full variable syntax=20
('{{managed_admin_users}}'). This feature will be removed in a future r=
elease.=20
Deprecation warnings can be disabled by setting deprecation_warnings=3D=
=46alse in=20
ansible.cfg.

TASK [users : Create all users without sudo access.] ******************=
*********
[DEPRECATION WARNING]: Using bare variables is deprecated. Update your=20
playbooks so that the environment value uses the full variable syntax=20
('{{managed_users}}'). This feature will be removed in a future release=
=2E=20
Deprecation warnings can be disabled by setting deprecation_warnings=3D=
=46alse in=20
ansible.cfg.

TASK [users : Update authorized_keys for each user.] ******************=
*********
[DEPRECATION WARNING]: Using bare variables is deprecated. Update your=20
playbooks so that the environment value uses the full variable syntax=20
('{{managed_users|list + managed_admin_users|list}}'). This feature wil=
l be=20
removed in a future release. Deprecation warnings can be disabled by se=
tting=20
deprecation_warnings=3DFalse in ansible.cfg.

TASK [users : Filter the revoked_users list] **************************=
*********
skipping: [167.114.243.17]

TASK [users : Remove revoked users] ***********************************=
*********
[DEPRECATION WARNING]: Using bare variables is deprecated. Update your=20
playbooks so that the environment value uses the full variable syntax=20
('{{revoked_users}}'). This feature will be removed in a future release=
=2E=20
Deprecation warnings can be disabled by setting deprecation_warnings=3D=
=46alse in=20
ansible.cfg.

TASK [common : Log the OS name, version and release] ******************=
*********
ok: [167.114.243.17] =3D> {
    "msg": "Host 167.114.243.17 is running Ubuntu 14.04 (trusty)"
}

TASK [common : Including major version specific variables.] ***********=
*********
ok: [167.114.243.17] =3D> (item=3D/home/loic/software/ceph/ceph-cm-ansi=
ble/roles/common/vars/empty.yml)

TASK [common : include] ***********************************************=
*********
skipping: [167.114.243.17]

TASK [common : include] ***********************************************=
*********
included: /home/loic/software/ceph/ceph-cm-ansible/roles/common/tasks/a=
pt_systems.yml for 167.114.243.17

TASK [common : Get the current timezone] ******************************=
*********
ok: [167.114.243.17]

TASK [common : Set the timezone in /etc/timezone] *********************=
*********
skipping: [167.114.243.17]

TASK [common : Inform the OS of the new timezone] *********************=
*********
skipping: [167.114.243.17]

TASK [common : include] ***********************************************=
*********
included: /home/loic/software/ceph/ceph-cm-ansible/roles/common/tasks/k=
erberos.yml for 167.114.243.17

TASK [common : Install Kerberos Packages (RedHat)] ********************=
*********
skipping: [167.114.243.17]

TASK [common : Update apt cache.] *************************************=
*********
ok: [167.114.243.17]

TASK [common : Install Kerberos Packages (Debian)] ********************=
*********
changed: [167.114.243.17]

TASK [common : Add krb5 config file] **********************************=
*********
changed: [167.114.243.17]

TASK [users : Merge extra_admin_users into managed_admin_users] *******=
*********
skipping: [167.114.243.17]

TASK [users : Remove managed_admin_users from managed_users] **********=
*********
skipping: [167.114.243.17]

TASK [users : Filter the managed_users list] **************************=
*********
skipping: [167.114.243.17]

TASK [users : Filter the managed_admin_users list] ********************=
*********
skipping: [167.114.243.17]

TASK [users : Create all admin users with sudo access.] ***************=
*********
[DEPRECATION WARNING]: Using bare variables is deprecated. Update your=20
playbooks so that the environment value uses the full variable syntax=20
('{{managed_admin_users}}'). This feature will be removed in a future r=
elease.=20
Deprecation warnings can be disabled by setting deprecation_warnings=3D=
=46alse in=20
ansible.cfg.

TASK [users : Create all users without sudo access.] ******************=
*********
[DEPRECATION WARNING]: Using bare variables is deprecated. Update your=20
playbooks so that the environment value uses the full variable syntax=20
('{{managed_users}}'). This feature will be removed in a future release=
=2E=20
Deprecation warnings can be disabled by setting deprecation_warnings=3D=
=46alse in=20
ansible.cfg.

TASK [users : Update authorized_keys for each user.] ******************=
*********
[DEPRECATION WARNING]: Using bare variables is deprecated. Update your=20
playbooks so that the environment value uses the full variable syntax=20
('{{managed_users|list + managed_admin_users|list}}'). This feature wil=
l be=20
removed in a future release. Deprecation warnings can be disabled by se=
tting=20
deprecation_warnings=3DFalse in ansible.cfg.

TASK [users : Filter the revoked_users list] **************************=
*********
skipping: [167.114.243.17]

TASK [users : Remove revoked users] ***********************************=
*********
[DEPRECATION WARNING]: Using bare variables is deprecated. Update your=20
playbooks so that the environment value uses the full variable syntax=20
('{{revoked_users}}'). This feature will be removed in a future release=
=2E=20
Deprecation warnings can be disabled by setting deprecation_warnings=3D=
=46alse in=20
ansible.cfg.

TASK [paddles : Include secrets] **************************************=
*********
fatal: [167.114.243.17]: FAILED! =3D> {"censored": "the output has been=
 hidden due to the fact that 'no_log: true' was specified for this resu=
lt"}
 [WARNING]: Failure when attempting to use callback plugin
(</home/loic/software/ceph/ceph-cm-
ansible/callback_plugins/failure_log.CallbackModule object at 0x7ff9c73=
8af10>):
runner_on_failed() takes at least 3 arguments (3 given)


NO MORE HOSTS LEFT ****************************************************=
*********
	to retry, use: --limit @paddles.retry

PLAY RECAP ************************************************************=
*********
167.114.243.17             : ok=3D9    changed=3D2    unreachable=3D0  =
  failed=3D1  =20


--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
