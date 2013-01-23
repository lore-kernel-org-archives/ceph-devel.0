From: Gregory Farnum <greg@inktank.com>
Subject: Re: Using a Data Pool
Date: Wed, 23 Jan 2013 15:57:06 -0800
Message-ID: <02132714F24E4CF799A39D1F0656073E@inktank.com>
References: <480DDC4F67FD9A438EE28BFEB1299FA98981C0A3@EX3.HQDOMAIN.LOCAL>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:38298 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab3AWX5L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 18:57:11 -0500
Received: by mail-pa0-f41.google.com with SMTP id bj3so5128288pad.28
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 15:57:10 -0800 (PST)
In-Reply-To: <480DDC4F67FD9A438EE28BFEB1299FA98981C0A3@EX3.HQDOMAIN.LOCAL>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Sherriffs <PSherriffs@humancircuit.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Wednesday, January 23, 2013 at 5:01 AM, Paul Sherriffs wrote:
> Hello All;
> =20
> I have been trying to associate a directory to a data pool (both call=
ed 'Media') according to a previous thread on this list. It all works e=
xcept the last line:
> =20
> =20
> ceph osd pool create Media 500 500
> =20
> ceph mds add_data_pool 3
> =20
> > added data pool 3 to mdsmap
> =20
> mkdir /mnt/ceph/Media
> =20
> cephfs /mnt/ceph/Media set_layout -p 3
> =20
> > Segmentation fault
cephfs is not a super-friendly tool right now =E2=80=94 sorry! :(
I believe you will find it works correctly if you specify all the layou=
t parameters, not just one of them.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
