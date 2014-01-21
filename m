From: Laurent Barbe <laurent@ksperis.com>
Subject: Re: CEPH_FEATURE_OSD_CACHEPOOL always required when osd cache pool
 exist ?
Date: Tue, 21 Jan 2014 11:03:55 +0100
Message-ID: <52DE460B.603@ksperis.com>
References: <52DE2F90.9030201@ksperis.com> <CALFYKtD8pTFXogm5-Uo50vpxN2fVKdOfKovo44TdLFCH8zQ+XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:39262 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbaAUKD6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jan 2014 05:03:58 -0500
Received: by mail-wg0-f45.google.com with SMTP id n12so7950802wgh.24
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jan 2014 02:03:57 -0800 (PST)
In-Reply-To: <CALFYKtD8pTFXogm5-Uo50vpxN2fVKdOfKovo44TdLFCH8zQ+XA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thank you for your reply Ilya.

However, this means that if we want to activate a pool with cache, it=20
will be necessary to upgrade the kernel of all clients even if they do=20
not use this feature. :(

Regards,

Laurent Barbe


Le 21/01/2014 10:46, Ilya Dryomov a =E9crit :
> On Tue, Jan 21, 2014 at 10:28 AM, Laurent Barbe <laurent@ksperis.com>=
 wrote:
>> Hi all,
>>
>> About 0.75, when I created cache pool, kernel client like rbd or cep=
hfs make
>> error "feature set mismatch". (Even if the device is not on the cach=
ed pool)
>>
>> $ rbd map rbd/myrbd    =3D> OK
>>
>> $ ceph osd pool create otherpool1 100 100
>> $ ceph osd pool create otherpool2 100 100
>> $ ceph osd tier add otherpool1 otherpool2
>> $ ceph osd tier cache-mode otherpool2 writeback
>>
>> $ rbd map rbd/myrbd
>> kern log >> libceph: mon2 10.2.0.90:6789 feature set mismatch, my 4a=
042a42 <
>> server's 84a042a42, missing 800000000
>>
>> Does the commit
>> https://github.com/ceph/ceph/commit/431a13eb370310a383abceeb509fe204=
a519e087
>> fix this ?
>
> No, I don't think so.  I might be wrong, but I think the idea is to
> require OSD_CACHEPOOL feature if any tiering relationships are presen=
t.
> Work on the kernel client is on-going, tiering support should arrive =
in
> 3.14.
>
> Thanks,
>
>                  Ilya
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
