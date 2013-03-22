From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Latest 0.56.3 and qemu-1.4.0 and cloned VM-image producing massive
 fs-corruption, not crashing
Date: Fri, 22 Mar 2013 12:30:23 -0700
Message-ID: <514CB14F.8040209@inktank.com>
References: <34E007C3-D952-4350-83FA-F9BC34294EEF@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:58228 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab3CVTbS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Mar 2013 15:31:18 -0400
Received: by mail-da0-f41.google.com with SMTP id w4so2457774dam.28
        for <ceph-devel@vger.kernel.org>; Fri, 22 Mar 2013 12:31:18 -0700 (PDT)
In-Reply-To: <34E007C3-D952-4350-83FA-F9BC34294EEF@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oliver Francke <Oliver.Francke@filoo.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/22/2013 12:09 PM, Oliver Francke wrote:
> Hi Josh, all,
>
> I did not want to hijack the thread dealing with a crashing VM, but p=
erhaps there are some common things.
>
> Today I installed a fresh cluster with mkephfs, went fine, imported a=
 "master" debian 6.0 image with "format 2", made a snapshot, protected =
it, and made some clones.
> Clones mounted with qemu-nbd, fiddled a bit with IP/interfaces/hosts/=
net.rules=85etc and cleanly unmounted, VM started, took 2 secs and the =
VM was up n running. Cool.
>
> Now an ordinary shutdown was performed, made a snapshot of this image=
=2E Started again, did some "apt-get update=85 install s/t=85".
> Shutdown -> rbd rollback -> startup again -> login -> install s/t els=
e=85 filesystem showed "many" ex3-errors, fell into read-only mode, mas=
sive corruption.

This sounds like it might be a bug in rollback. Could you try cloning
and snapshotting again, but export the image before booting, and after
rolling back, and compare the md5sums?

Running the rollback with:

--debug-ms 1 --debug-rbd 20 --log-file rbd-rollback.log

might help too. Does your ceph.conf where you ran the rollback have
anything related to rbd_cache in it?

> qemu config was with ":rbd_cache=3Dfalse" if it matters. Above scenar=
io is reproducible, and as I stated out, no crash detected.
>
> Perhaps it is in the same area as in the crash-thread, otherwise I wi=
ll provide logfiles as needed.

It's unrelated, the other thread is an issue with the cache, which does
not cause corruption but triggers a crash.

Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
