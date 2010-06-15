From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: setup ceph cluster failed
Date: Tue, 15 Jun 2010 13:12:32 -0700
Message-ID: <AANLkTikuhGLl59papaPJPvfN584gPi-B10xiXIZNrS-O@mail.gmail.com>
References: <AANLkTikdrTuquXK2sr5rz4rRASJWHvkVzkw4Y26rusds@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62103 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab0FOUMe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jun 2010 16:12:34 -0400
Received: by vws13 with SMTP id 13so1674005vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jun 2010 13:12:33 -0700 (PDT)
In-Reply-To: <AANLkTikdrTuquXK2sr5rz4rRASJWHvkVzkw4Y26rusds@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Min Zhou <coderplay@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 15, 2010 at 1:09 PM, Min Zhou <coderplay@gmail.com> wrote:
> Hi all,
>
> I am a newbie of ceph, and didn't =A0find any ceph mailing list for
> users, so I send a mail here ask for helping.
> below is the error information
>
> $ mkcephfs --allhosts -c ceph_conf/ceph.conf -v
> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon =A0"mon =
addr" ""
> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon =A0"mon =
addr" ""
> /home/ceph/ceph/bin/monmaptool --create --clobber --add
> 192.168.0.2:6789 --add 192.168.0.3:6789 --print /tmp/monmap.8107
> /home/ceph/ceph/bin/monmaptool: monmap file /tmp/monmap.8107
> /home/ceph/ceph/bin/monmaptool: generated fsid
> 2b00c868-cfd6-2473-c27d-302b5cddc194
> epoch 1
> fsid 2b00c868-cfd6-2473-c27d-302b5cddc194
> last_changed 10.06.16 04:02:28.247612
> created 10.06.16 04:02:28.247612
> =A0 =A0 =A0 =A0mon0 192.168.0.2:6789/0
> =A0 =A0 =A0 =A0mon1 192.168.0.3:6789/0
> /home/ceph/ceph/bin/monmaptool: writing epoch 1 to /tmp/monmap.8107 (=
2 monitors)
> max osd in ceph_conf/ceph.conf is 2, num osd is 3
> /home/ceph/ceph/bin/osdmaptool: osdmap file '/tmp/osdmap.8107'
> /home/ceph/ceph/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.8107
> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon =A0"crus=
h map src" ""
> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 1 -t mon =A0"crus=
h map" ""
> Building admin keyring at /tmp/admin.keyring.8107
> creating /tmp/admin.keyring.8107
> Building monitor keyring with all service keys
> creating /tmp/monkeyring.8107
> importing contents of /tmp/admin.keyring.8107 into /tmp/monkeyring.81=
07
> creating /tmp/keyring.mds.0
> importing contents of /tmp/keyring.mds.0 into /tmp/monkeyring.8107
> creating /tmp/keyring.mds.1
> importing contents of /tmp/keyring.mds.1 into /tmp/monkeyring.8107
> creating /tmp/keyring.mds.a
> importing contents of /tmp/keyring.mds.a into /tmp/monkeyring.8107
> creating /tmp/keyring.osd.0
> importing contents of /tmp/keyring.osd.0 into /tmp/monkeyring.8107
> creating /tmp/keyring.osd.1
> importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.8107
> creating /tmp/keyring.osd.2
> importing contents of /tmp/keyring.osd.2 into /tmp/monkeyring.8107
> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon =A0"user=
" ""
> =3D=3D=3D mon0 =3D=3D=3D
> /home/ceph/ceph/bin/cconf -c ceph_conf/ceph.conf -i 0 -t mon =A0"mon =
data" ""
> /home/ceph/ceph/lib/ceph/ceph_common.sh: eval: line 167: unexpected

Can you send your ceph.conf?

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
