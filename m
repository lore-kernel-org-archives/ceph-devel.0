From: Gregory Farnum <greg@inktank.com>
Subject: Re: strange issues recovering from inconsistent state
Date: Mon, 1 Oct 2012 09:47:34 -0700
Message-ID: <CAPYLRzg9_1XpOTqAO6tv5r=q2SO3ySbQr9-9xnPJnpW7xaaQ1Q@mail.gmail.com>
References: <CAJvS2pqSE6LicpDAz_DBYwHwWkS6F3uE78gn+dostmLhNNY7Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54463 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab2JAQre convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 12:47:34 -0400
Received: by ieak13 with SMTP id k13so12599171iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 09:47:34 -0700 (PDT)
In-Reply-To: <CAJvS2pqSE6LicpDAz_DBYwHwWkS6F3uE78gn+dostmLhNNY7Lw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sergey Tsalkov <stsalkov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Yehuda Sadeh <yehuda@inktank.com>

On Fri, Sep 28, 2012 at 10:12 PM, Sergey Tsalkov <stsalkov@gmail.com> w=
rote:
> So we're running a 3-machine cluster with ceph 0.52 on ubuntu precise=
=2E
> Our cluster has 2 machines with 5 osds each, and a third machine with
> a rados gateway. Each machine has a mon. The default crushmap is
> putting a copy of the data on each machine, so 2 copies total. All of
> our reads and writes are done over the S3 gateway.
>
> We were curious about how it handled inconsistent file states so we
> uploaded a text file, then went into the osd data
> (/var/lib/ceph/osd/ceph-9/...) and changed that file on disk on one o=
f
> the two osds. The cluster didn't automatically discover any errors,
> still reported HEALTH_OK, and S3 happily returned the broken copy of
> the file.

This portion of RADOS is...limited =97 you are essentially dependent on
the underlying FS to not give you back bad data. So I'm not expecting
this to do what you want.


> We then did "ceph osd repair 9" (which is cheating since we knew whic=
h
> osd we'd broken it on). It discovered the error but didn't fix it, an=
d
> now "ceph health detail" was returning "pg 9.7 is
> active+clean+inconsistent, acting [9,4]". Additional repair attempts
> didn't help.
At this point, Ceph has compared metadata across nodes and determined
that it's inconsistent. Right now though, "recovery" just means
copying the primary OSD's data to all the other OSDs, so it's not a
great fix.


> We then restarted all of the osds. The cluster was now reporting
> HEALTH_OK again, and kept reporting that even after we re-ran the
> repair command. The repair command still detected the inconsistency,
> though:
> 2012-09-28 21:46:58.068140 osd.9 [ERR] repair 9.7
> 994c51ff/4712.1_functions_admin.php/head//9 on disk size (90965) does
> not match object info size (91183)

So it looks like you successfully destroyed the primary copy when
changing one of the on-disk versions, and now the file and Ceph's
metadata about the file don't match.


> We then tried using S3 to download the broken file again. Every time
> we tried, it sent us the broken copy of the file, and then the rados
> gateway crashed as soon as the send was done. I restarted the gateway=
,
> and was able to reproduce this.
That's a little strange. Do you have logging? Probably there's
something about the reply being shorter than expected.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
