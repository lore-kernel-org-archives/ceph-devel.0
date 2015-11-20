From: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Subject: Re: OSD replacement feature
Date: Fri, 20 Nov 2015 15:55:31 +0800
Message-ID: <CABF_e-EyHHse14RGJnHTipZ+uG+8d0LyLVuYYJAh-NOmDXnPfA@mail.gmail.com>
References: <564E04F9.20607@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33332 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934361AbbKTHzc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 02:55:32 -0500
Received: by obbww6 with SMTP id ww6so80800357obb.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 23:55:32 -0800 (PST)
In-Reply-To: <564E04F9.20607@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic and cephers,

Sure, I have time to help (comment) on this feature replace a disk.
This is a useful feature to handle disk failure :p

An simple step is described on http://tracker.ceph.com/issues/13732 :
1. set noout flag - if the broken osd is primary osd, could we handle w=
ell?
2. stop osd daemon and we need to wait the osd actually down. (or
maybe use deactivate option with ceph-disk)

these two above step seems OK.
about handle crush map, should we remove the broken osd out?
If we do that, why we set noout flag? It still trigger re-balance
after we remove osd from crushmap.

Could we just remove the auth key and re-create osd with new disk
(then add the auth key back)?

I will try and test myself.

feel free to let me know if you have any suggeations!

thanks!!!
vicente


2015-11-20 1:20 GMT+08:00 Loic Dachary <loic@dachary.org>:
> Hi Vicente,
>
> Now that your ceph-disk deactivate/destroy feature is merged (and doc=
umented ;-), I wonder if you have time to comment on http://tracker.cep=
h.com/issues/13732 which is about replacing a disk ? Your input would b=
e much appreciated.
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
