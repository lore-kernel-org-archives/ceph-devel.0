From: Thierry Delamare <t.delamare@laposte.net>
Subject: Re: configuring ansible apt-repository for i386
Date: Sun, 27 Mar 2016 13:33:33 +0200
Message-ID: <56F7C50D.7060703@laposte.net>
References: <56F72926.8000402@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpoutz298.laposte.net ([178.22.154.198]:53257 "EHLO
	smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751353AbcC0LzR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Mar 2016 07:55:17 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
	by lpn-prd-vrout010 (Postfix) with ESMTP id 4ED5A459B79
	for <ceph-devel@vger.kernel.org>; Sun, 27 Mar 2016 13:33:34 +0200 (CEST)
Received: from lpn-prd-vrin001 (lpn-prd-vrin001.laposte [10.128.63.2])
	by lpn-prd-vrout010 (Postfix) with ESMTP id 49E80459955
	for <ceph-devel@vger.kernel.org>; Sun, 27 Mar 2016 13:33:34 +0200 (CEST)
Received: from lpn-prd-vrin001 (localhost [127.0.0.1])
	by lpn-prd-vrin001 (Postfix) with ESMTP id 2BCDF3653F4
	for <ceph-devel@vger.kernel.org>; Sun, 27 Mar 2016 13:33:34 +0200 (CEST)
In-Reply-To: <56F72926.8000402@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 03/27/2016 01:28 AM, Loic Dachary wrote:
> Hi Thierry,
>
> Running on an i386 host, ansible does the following:
>
> TASK: [testnode | Add local apt repos.] *************************************** ^M
>
> 2016-03-27 00:16:20,737.737 INFO:teuthology.task.ansible.out:^[[0;33mchanged: [target167114241144.teuthology] => (item=deb http://gitbuilder.ceph.com/libapache-mod-fastcgi-deb-trusty-x86_64-basic/ref/master/ trusty main) => {"changed": true, "item": "deb http://gitbuilder.ceph.com/libapache-mod-fastcgi-deb-trusty-x86_64-basic/ref/master/ trusty main", "repo": "deb http://gitbuilder.ceph.com/libapache-mod-fastcgi-deb-trusty-x86_64-basic/ref/master/ trusty main", "state": "present"}^[[0m
>
> where x86_64 should be i386. I traced that back to
>
> https://github.com/ceph/ceph-cm-ansible/blob/master/roles/testnode/tasks/apt/repos.yml#L52
>
> - name: Add local apt repos.
>    apt_repository:
>      repo: "{{ item }}"
>      state: present
>      update_cache: no
>      mode: 0644
>    with_items: apt_repos|list + common_apt_repos|list
>    register: local_apt_repos
>
> Do you know how I canfigure out where "item" (which is presumably the incorrect http://gitbuilder.ceph.com/libapache-mod-fastcgi-deb-trusty-x86_64-basic/ref/master/ here) is set ?
>
> Cheers
>
Salut Loic,

- This task iterate over the cat of two vars (apt_repos and 
common_apt_repos (yaml list, jinja, iterable converted to list))
- These vars are (as expected) defined in the std role vars dir 
(testnode/vars)
   - ansible auto include vars/main.yml, but in this case, as we mainly 
have distribution specific vars, the include come from 
testnode/tasks/vars.yml (testnode/tasks/vars.yml being itself the first 
task of testnode/tasks/main.yml)
   - testnode/tasks/vars.yml use ansible auto defined variables (like 
ansible_distribution or ansible_distribution_major_version) to include 
the correct files from testnode/tasks (eg. centos_7.yml or ubuntu_14.yml)
- As a quick an dirty fix or test step you can always redefine a var at 
ansible invocation using --extra-vars (but you will need to use yaml or 
json instead of key=val because common_apt_repos expect a list)
- A simple fix could probably be to replace the srt x86_64 by 
ansible_architecture in testnode/vars files where it occurs

- In your specific case:

   echo -e '/x86_64/s//{{ansible_architecture}}/\nwq' | ed 
roles/testnode/vars/ubuntu.yml

- But maybe also in centos_{6,7} debian7 redhat{6,7}


-- 
Thierry Delamare
t.delamare@laposte.net
06 10 60 56 00

