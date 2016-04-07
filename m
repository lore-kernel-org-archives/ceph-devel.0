From: Thierry Delamare <t.delamare@laposte.net>
Subject: Re: aarch64 conditional ansible stanza
Date: Thu, 7 Apr 2016 15:58:51 +0200
Message-ID: <5706679B.6030606@laposte.net>
References: <5706025B.3080205@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpoutz298.laposte.net ([178.22.154.198]:53714 "EHLO
	smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755557AbcDGN64 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 09:58:56 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
	by lpn-prd-vrout010 (Postfix) with ESMTP id 4B9A245A1FF
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 15:58:54 +0200 (CEST)
Received: from lpn-prd-vrin001 (lpn-prd-vrin001.laposte [10.128.63.2])
	by lpn-prd-vrout010 (Postfix) with ESMTP id 45DB145A1D8
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 15:58:54 +0200 (CEST)
Received: from lpn-prd-vrin001 (localhost [127.0.0.1])
	by lpn-prd-vrin001 (Postfix) with ESMTP id 34E86365C16
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 15:58:54 +0200 (CEST)
In-Reply-To: <5706025B.3080205@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 04/07/2016 08:46 AM, Loic Dachary wrote:
> Hi Thierry,
>
> In order to only install a template on architectures that are not aar=
ch64, I changed
>
> - name: Add sources list
>    template:
>      dest: /etc/apt/sources.list
>      src: "../../templates/apt/sources.list.{{ ansible_distribution_r=
elease | lower }}"
>      owner: root
>      group: root
>      mode: 0644
>    register: sources
>
> into
>
> - name: Add sources list
>    template:
>      dest: /etc/apt/sources.list
>      src: "../../templates/apt/sources.list.{{ ansible_distribution_r=
elease | lower }}"
>      owner: root
>      group: root
>      mode: 0644
>    register: sources
>    when: {{ansible_architecture}} !=3D aarch64
>
> Is there a better way to do that ?
Bonjour Loic,

Using when statement is the correct way to add conditions to a task,
but don't forget that the when clause contains a Jinja2 expression (not=
=20
like a module argument),
Thus the correct expression should rather be =C2=AB when:=20
ansible_architecture !=3D 'aarch64' =C2=BB.

a+


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
