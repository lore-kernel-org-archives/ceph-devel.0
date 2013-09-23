From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Hiding auth key string for the qemu process
Date: Mon, 23 Sep 2013 01:23:29 -0700
Message-ID: <523FFA81.8000101@inktank.com>
References: <CABYiri_WXi-CCtJBJZSsy7t8MsX6kVdq=OHKiRmS+kDhekhyiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:43352 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab3IWIXb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 04:23:31 -0400
Received: by mail-oa0-f43.google.com with SMTP id f4so309300oah.30
        for <ceph-devel@vger.kernel.org>; Mon, 23 Sep 2013 01:23:31 -0700 (PDT)
In-Reply-To: <CABYiri_WXi-CCtJBJZSsy7t8MsX6kVdq=OHKiRmS+kDhekhyiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>, ceph-devel <ceph-devel@vger.kernel.org>

On 09/22/2013 12:54 PM, Andrey Korolyov wrote:
> Hello,
>
> Since it was a long time from enabling cephx by default and we may
> think that everyone using it, is seems worthy to introduce bits of
> code hiding the key from cmdline. First applicable place for such
> improvement is most-likely OpenStack envs with their sparse security
> and usage of admin key as default one.

I doubt most people are using the admin keyring, since the docs for
openstack show different users for images and volumes, but it's worth
tackling this again.

Basically this requires changing QEMU and making libvirt use the new 
interface when it's available. There was some discussion [1] and an rfc
[2] a while back regarding this. The same approach of modifying the
bdrv_set_key command should work, but IIRC there was a complication
that could be corrected. QEMU attempted to read the device size before
pausing the vm and waiting for the password (cephx secret in this
case), but with rbd the size isn't available until after the driver has
the secret with which to connect to the cluster. If the vm were paused
before the size of the disk was read, the patches would be simpler.

It's probably not too hard to rework those patches if anyone's
interested in picking them up.

Josh

[1] http://www.redhat.com/archives/libvir-list/2011-October/msg00998.html
[2] http://lists.gnu.org/archive/html/qemu-devel/2011-11/msg01337.html
