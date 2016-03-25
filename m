From: Loic Dachary <loic@dachary.org>
Subject: Re: installing paddles via ansible
Date: Fri, 25 Mar 2016 18:47:40 +0100
Message-ID: <56F579BC.9020801@dachary.org>
References: <56D6D7F9.4010104@dachary.org> <56F57325.6080807@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39176 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbcCYRrp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Mar 2016 13:47:45 -0400
In-Reply-To: <56F57325.6080807@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thierry Delamare <t.delamare@laposte.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

One additional trick to avoid the creation of the host file and install=
 paddles on the same host that is running ansible:

ansible-playbook -i paddles, -c local paddles.yml

On 25/03/2016 18:19, Loic Dachary wrote:
> Hi Thierry,
>=20
> Thanks for the hand holding today and congrats on your first paddles =
installation :-) To summarize what we did:
>=20
> * git clone --recursive -b stable-1.9 https://github.com/ansible/ansi=
ble.git
> * cd ansible ; source hacking/env-setup
> * cd ceph-cm-ansible
> * cat > /etc/ansible/secrets/paddles.yml <<EOF
> ---
> db_pass: toto
> EOF
> * cat > host <<EOF
> [paddles]
> 149.202.170.114
> [paddles:vars]
> ansible_ssh_user=3Dubuntu
> ansible_ssh_keys=3D/home/loic/.ssh/id_rsa
> EOF
> ansible-playbook -v -i host paddles.yml
>=20
> firefox http://149.202.170.114:8080/
> {"_help_": {"docs": "https://github.com/ceph/paddles", "extensions": =
{"Chrome": "https://chrome.google.com/webstore/detail/jsonview/chklaanh=
fefbnpoihckbnefhakgolnmc", "Firefox": "https://addons.mozilla.org/en-US=
/firefox/addon/jsonview/"}}, "last_job": " ago", "last_run": " ago"}
>=20
> The fixes we made have been added to a pull request at https://github=
=2Ecom/ceph/ceph-cm-ansible/pull/219
>=20
> I'll also remember that:
>=20
> * Whenever an error message such as:
>=20
> TASK: [paddles | Set paddles_address] *******************************=
**********=20
> fatal: [149.202.170.114] =3D> error while evaluating conditional: not=
 paddles_address.startswith('http')
>=20
> is displayed, finding the file responsible for it is best served by g=
repping the string after the | "Set paddles_address" in this case. Ther=
e is no way to ask ansible to display the line and the file where the e=
rror happens, in the same way a compiler would.
>=20
> * I discovered the expected structure of the secret file content by c=
hecking out the secret ansible secret repository, running find | grep p=
addles and uncrypting the secret file using the password found on a sec=
ret machine to which I luckily had access. But I did not show you the s=
ecret password so it's still a secret.
>=20
> Cheers
>=20
> On 02/03/2016 13:09, Loic Dachary wrote:
>> Hi Zack,
>>
>> I'm running ansible to deploy paddles as follows. I am missing secre=
ts. But I have no secrets :-) This is just a standalone instance for te=
sts, what would be the minimal way to define the secrets paddle needs ?
>>
>> Thanks in advance for your help !
>>
>> $ cat host
>> [paddles]
>> 167.114.243.17
>> [paddles:vars]
>> ansible_ssh_user=3Dubuntu
>> ansible_ssh_keys=3D/home/loic/.ssh/id_rsa
>>
>> (virtualenv)loic@fold:~/software/ceph/ceph-cm-ansible$ ansible-playb=
ook -i host paddles.yml=20
>>
>> PLAY ***************************************************************=
************
>>
>> TASK [setup] *******************************************************=
************
>> ok: [167.114.243.17]
>>
>> TASK [users : Merge extra_admin_users into managed_admin_users] ****=
************
>> skipping: [167.114.243.17]
>>
>> TASK [users : Remove managed_admin_users from managed_users] *******=
************
>> skipping: [167.114.243.17]
>>
>> TASK [users : Filter the managed_users list] ***********************=
************
>> skipping: [167.114.243.17]
>>
>> TASK [users : Filter the managed_admin_users list] *****************=
************
>> skipping: [167.114.243.17]
>>
>> TASK [users : Create all admin users with sudo access.] ************=
************
>> [DEPRECATION WARNING]: Using bare variables is deprecated. Update yo=
ur=20
>> playbooks so that the environment value uses the full variable synta=
x=20
>> ('{{managed_admin_users}}'). This feature will be removed in a futur=
e release.=20
>> Deprecation warnings can be disabled by setting deprecation_warnings=
=3DFalse in=20
>> ansible.cfg.
>>
>> TASK [users : Create all users without sudo access.] ***************=
************
>> [DEPRECATION WARNING]: Using bare variables is deprecated. Update yo=
ur=20
>> playbooks so that the environment value uses the full variable synta=
x=20
>> ('{{managed_users}}'). This feature will be removed in a future rele=
ase.=20
>> Deprecation warnings can be disabled by setting deprecation_warnings=
=3DFalse in=20
>> ansible.cfg.
>>
>> TASK [users : Update authorized_keys for each user.] ***************=
************
>> [DEPRECATION WARNING]: Using bare variables is deprecated. Update yo=
ur=20
>> playbooks so that the environment value uses the full variable synta=
x=20
>> ('{{managed_users|list + managed_admin_users|list}}'). This feature =
will be=20
>> removed in a future release. Deprecation warnings can be disabled by=
 setting=20
>> deprecation_warnings=3DFalse in ansible.cfg.
>>
>> TASK [users : Filter the revoked_users list] ***********************=
************
>> skipping: [167.114.243.17]
>>
>> TASK [users : Remove revoked users] ********************************=
************
>> [DEPRECATION WARNING]: Using bare variables is deprecated. Update yo=
ur=20
>> playbooks so that the environment value uses the full variable synta=
x=20
>> ('{{revoked_users}}'). This feature will be removed in a future rele=
ase.=20
>> Deprecation warnings can be disabled by setting deprecation_warnings=
=3DFalse in=20
>> ansible.cfg.
>>
>> TASK [common : Log the OS name, version and release] ***************=
************
>> ok: [167.114.243.17] =3D> {
>>     "msg": "Host 167.114.243.17 is running Ubuntu 14.04 (trusty)"
>> }
>>
>> TASK [common : Including major version specific variables.] ********=
************
>> ok: [167.114.243.17] =3D> (item=3D/home/loic/software/ceph/ceph-cm-a=
nsible/roles/common/vars/empty.yml)
>>
>> TASK [common : include] ********************************************=
************
>> skipping: [167.114.243.17]
>>
>> TASK [common : include] ********************************************=
************
>> included: /home/loic/software/ceph/ceph-cm-ansible/roles/common/task=
s/apt_systems.yml for 167.114.243.17
>>
>> TASK [common : Get the current timezone] ***************************=
************
>> ok: [167.114.243.17]
>>
>> TASK [common : Set the timezone in /etc/timezone] ******************=
************
>> skipping: [167.114.243.17]
>>
>> TASK [common : Inform the OS of the new timezone] ******************=
************
>> skipping: [167.114.243.17]
>>
>> TASK [common : include] ********************************************=
************
>> included: /home/loic/software/ceph/ceph-cm-ansible/roles/common/task=
s/kerberos.yml for 167.114.243.17
>>
>> TASK [common : Install Kerberos Packages (RedHat)] *****************=
************
>> skipping: [167.114.243.17]
>>
>> TASK [common : Update apt cache.] **********************************=
************
>> ok: [167.114.243.17]
>>
>> TASK [common : Install Kerberos Packages (Debian)] *****************=
************
>> changed: [167.114.243.17]
>>
>> TASK [common : Add krb5 config file] *******************************=
************
>> changed: [167.114.243.17]
>>
>> TASK [users : Merge extra_admin_users into managed_admin_users] ****=
************
>> skipping: [167.114.243.17]
>>
>> TASK [users : Remove managed_admin_users from managed_users] *******=
************
>> skipping: [167.114.243.17]
>>
>> TASK [users : Filter the managed_users list] ***********************=
************
>> skipping: [167.114.243.17]
>>
>> TASK [users : Filter the managed_admin_users list] *****************=
************
>> skipping: [167.114.243.17]
>>
>> TASK [users : Create all admin users with sudo access.] ************=
************
>> [DEPRECATION WARNING]: Using bare variables is deprecated. Update yo=
ur=20
>> playbooks so that the environment value uses the full variable synta=
x=20
>> ('{{managed_admin_users}}'). This feature will be removed in a futur=
e release.=20
>> Deprecation warnings can be disabled by setting deprecation_warnings=
=3DFalse in=20
>> ansible.cfg.
>>
>> TASK [users : Create all users without sudo access.] ***************=
************
>> [DEPRECATION WARNING]: Using bare variables is deprecated. Update yo=
ur=20
>> playbooks so that the environment value uses the full variable synta=
x=20
>> ('{{managed_users}}'). This feature will be removed in a future rele=
ase.=20
>> Deprecation warnings can be disabled by setting deprecation_warnings=
=3DFalse in=20
>> ansible.cfg.
>>
>> TASK [users : Update authorized_keys for each user.] ***************=
************
>> [DEPRECATION WARNING]: Using bare variables is deprecated. Update yo=
ur=20
>> playbooks so that the environment value uses the full variable synta=
x=20
>> ('{{managed_users|list + managed_admin_users|list}}'). This feature =
will be=20
>> removed in a future release. Deprecation warnings can be disabled by=
 setting=20
>> deprecation_warnings=3DFalse in ansible.cfg.
>>
>> TASK [users : Filter the revoked_users list] ***********************=
************
>> skipping: [167.114.243.17]
>>
>> TASK [users : Remove revoked users] ********************************=
************
>> [DEPRECATION WARNING]: Using bare variables is deprecated. Update yo=
ur=20
>> playbooks so that the environment value uses the full variable synta=
x=20
>> ('{{revoked_users}}'). This feature will be removed in a future rele=
ase.=20
>> Deprecation warnings can be disabled by setting deprecation_warnings=
=3DFalse in=20
>> ansible.cfg.
>>
>> TASK [paddles : Include secrets] ***********************************=
************
>> fatal: [167.114.243.17]: FAILED! =3D> {"censored": "the output has b=
een hidden due to the fact that 'no_log: true' was specified for this r=
esult"}
>>  [WARNING]: Failure when attempting to use callback plugin
>> (</home/loic/software/ceph/ceph-cm-
>> ansible/callback_plugins/failure_log.CallbackModule object at 0x7ff9=
c738af10>):
>> runner_on_failed() takes at least 3 arguments (3 given)
>>
>>
>> NO MORE HOSTS LEFT *************************************************=
************
>> 	to retry, use: --limit @paddles.retry
>>
>> PLAY RECAP *********************************************************=
************
>> 167.114.243.17             : ok=3D9    changed=3D2    unreachable=3D=
0    failed=3D1  =20
>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
