From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: Make Openstack work with Ceph
Date: Thu, 8 Mar 2012 09:58:42 +0100
Message-ID: <CAMvP8PCRdcmcM7wYid0_G7FMWGLO4LNUdxOKGi+24hWMdZyHjg@mail.gmail.com>
References: <4F586F49.4070703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:60684 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754986Ab2CHI7C convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Mar 2012 03:59:02 -0500
Received: by obbuo6 with SMTP id uo6so372398obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Mar 2012 00:59:02 -0800 (PST)
In-Reply-To: <4F586F49.4070703@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Right now there's no clean way to do this. You need few scripts to
achive this. First you need to create volume, prepopulate it with
image from glance and later create an instance booting from it.
Scripts below are doing this task.

https://github.com/ceph/ceph-openstack-tools/blob/master/start-on-rbd.s=
h
https://github.com/ceph/ceph-openstack-tools/blob/master/boot-from-volu=
me


This is good enough but I'am working on solution to implement volume
imaging directly from nova-compute component. It's should be made
public within 3/4 weeks.



On Thu, Mar 8, 2012 at 9:35 AM, Chu Duc Minh <chu.ducminh@gmail.com> wr=
ote:
> Hi, i have built a Ceph cluster and a Openstack cluster for dev
> Ceph work quite smooth, i can mount it to client, or create disk imag=
e by
> using rbd, qemu-img,... command.
> But i dont' know how to make openstack use new Ceph cluster as the de=
fault
> Block Device Storage.
> (Openstack use KVM as default hypervisor and QCOW2 as default disk im=
age
> format)
>
> Can you give me some hint to configure Openstack(libvirt/..) to make =
it work
> with Ceph, pls?
>
> Thanks very much, folks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html



--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
