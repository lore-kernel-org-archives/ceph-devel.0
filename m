From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Reboot blocked when undoing unmap op.
Date: Fri, 20 Nov 2015 10:30:14 +0100
Message-ID: <CAOi1vP-eP_unRJFkZ-z2bQyWOcnpxnV+zBk1pRt2Q1OLnSU79Q@mail.gmail.com>
References: <47D132BF400BE64BAE6D71033F7D3D7518DD2C@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33171 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759514AbbKTJaQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Nov 2015 04:30:16 -0500
Received: by wmec201 with SMTP id c201so63194009wme.0
        for <ceph-devel@vger.kernel.org>; Fri, 20 Nov 2015 01:30:14 -0800 (PST)
In-Reply-To: <47D132BF400BE64BAE6D71033F7D3D7518DD2C@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wukongming <wu.kongming@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>

On Fri, Nov 20, 2015 at 3:19 AM, Wukongming <wu.kongming@h3c.com> wrote=
:
> Hi Sage,
>
> I created a rbd image, and mapped to a local which means I can find /=
dev/rbd0, at this time I reboot the system, in last step of shutting do=
wn, it blocked with an error
>
> [235618.0202207] libceph: connect 172.16.57.252:6789 error -101.
>
> My Works=E2=80=99 Env:
>
> Ubuntu kernel 3.19.0
> Ceph 0.94.5
> A cluster of 2 Servers with iscsitgt and open-iscsi, both as server a=
nd client. Multipath process is on but not affect this issue. I=E2=80=99=
ve tried stopping multipath, but the issue still there.
> I map a rbd image to a local, why show me a connect error?
>
> I saw your reply on http://permalink.gmane.org/gmane.comp.file-system=
s.ceph.devel/13077, but just apart. Is this issue resolved and how?

Yeah, this has been a long standing problem with libceph/rbd.  The
issue is that you *have* to umount (and ideally also unmap, but unmap
isn't strictly necessary) before you reboot.  Otherwise (and I assume
by mapped to a local you mean you've got MONs and OSDs on the same node
as you do rbd map), when you issue a reboot, daemons get killed and the
kernel client ends up waiting for the them to come back, because of
outstanding writes issued by umount called by systemd (or whatever).
There are other variations of this, but it all comes down to you having
to cold reboot.

The right fix is to have all init systems sequence the killing of ceph
daemons after the umount/unmap.  I also toyed with adding a reboot
notifier for libceph to save a cold reboot, but the problem with that
in the general case is data integrity.  However, in cases like the one
I described above, there is no going back so we might as well kill
libceph through a notifier.  I have an incomplete patch somewhere, but
it really shouldn't be necessary...

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
