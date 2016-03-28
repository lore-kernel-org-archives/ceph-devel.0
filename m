From: Thierry Delamare <t.delamare@laposte.net>
Subject: Re: ansible stalls because the inventory is too big
Date: Mon, 28 Mar 2016 15:07:46 +0200
Message-ID: <56F92CA2.2040001@laposte.net>
References: <56F85ED0.5060605@dachary.org> <56F85FB7.8050004@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpoutz300.laposte.net ([178.22.154.200]:52052 "EHLO
	smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753781AbcC1NHU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2016 09:07:20 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
	by lpn-prd-vrout012 (Postfix) with ESMTP id 0AF1E8A617
	for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2016 15:07:17 +0200 (CEST)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.laposte [10.128.63.4])
	by lpn-prd-vrout012 (Postfix) with ESMTP id 03F2D8A5E7
	for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2016 15:07:17 +0200 (CEST)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
	by lpn-prd-vrin003 (Postfix) with ESMTP id E3BCD48C3FE
	for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2016 15:07:16 +0200 (CEST)
In-Reply-To: <56F85FB7.8050004@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 03/28/2016 12:33 AM, Loic Dachary wrote:
> [resuming the previous mail, sent too early by mistake :-]
>
> On 28/03/2016 00:29, Loic Dachary wrote:
>> Hi Thierry,
>>
>> When teuthology runs ansible on a newly created host as:
>>
>> /home/ubuntu/teuthology/virtualenv/bin/python /home/ubuntu/teuthology/virtualenv/bin/ansible-playbook -v --extra-vars {"ansible_ssh_user": "ubuntu"} -i /etc/ansible/hosts --limit target010011010028.teuthology /home/ubuntu/src/ceph-cm-ansible_master/cephlab.yml
>>
>> it stalls because there are too many hosts in the inventory (65537) and
>>
>> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193.teuthology", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
>> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193.teuthology.yml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
>> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193.teuthology.yaml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
>> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203193.teuthology.json", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
>> newfstatat(AT_FDCWD, "/etc/ansible/hosts/", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
>> newfstatat(AT_FDCWD, "/etc/ansible/hosts", {st_mode=S_IFDIR|0755, st_size=4096, ...}, 0) = 0
>> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194.teuthology", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
>> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194.teuthology.yml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
>> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194.teuthology.yaml", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
>> newfstatat(AT_FDCWD, "/etc/ansible/hosts/host_vars/target010011203194.teuthology.json", 0x7fc8f1a4f0, AT_SYMLINK_NOFOLLOW) = -1 ENOENT (No such file or directory)
>>
>> takes forever. This is running on an ARMv8 virtual machine:
>>
> (virtualenv)ubuntu@teuthology:~/teuthology$ cat /proc/cpuinfo
> Processor	: AArch64 Processor rev 1 (aarch64)
> processor	: 0
> Features	: fp asimd evtstrm
> CPU implementer	: 0x50
> CPU architecture: AArch64
> CPU variant	: 0x0
> CPU part	: 0x000
> CPU revision	: 1
>
> Hardware	: linux,dummy-virt
>
> which also explains why it's not very fast. Do you know of a way to ask ansible to only consider one host instead of what appears to be a systematic exploration of all possible hosts in the inventory, only to finally select the one from the --limit argument ?
Salut loic,

I didn't test, I don't examine how exactly ansible implement inventory 
construction and I can't presently duplicate your testing environment.
This said, You could try to change ceph-cm-ansible/teuthology.yml to 
allow host restriction via play hosts directive rather than limit parameter.

echo -e "/hosts: teuthology/s/teuthology/\"{{ targets | 
default('teuthology') }}\"/\nwq" | ed ceph-cm-ansible/teuthology.yml

And then use a extra-vars param as usual.

The idea being that when using limit parameter you may need to access 
other hosts facts to achieve your play on limited target (or for 
delegated actions) and thus need to construct the full set of hosts facts.

If I guessed right, when limiting via hosts directive you explicitly 
choose a hosts subset (usually a group) from inventory before running 
the play rather than applying a filter at a later time.

If this works, some tasks may fail because you really need some other 
hosts from the inventory (say to enable delegated actions), but you 
could refine your targets variables by adding more hosts.



