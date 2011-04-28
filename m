From: huang jun <hjwsm1989@gmail.com>
Subject: Re: why client change "max_size" when writting?
Date: Thu, 28 Apr 2011 08:50:27 +0800
Message-ID: <BANLkTimfspbrgaTRoW+_rMH1ko3GEOZsHg@mail.gmail.com>
References: <BANLkTin4dUrh0J6TMjTv=w6bjC=dk7Gppw@mail.gmail.com>
	<Pine.LNX.4.64.1104270840190.27415@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61254 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab1D1Au3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 20:50:29 -0400
Received: by wwa36 with SMTP id 36so2508940wwa.1
        for <ceph-devel@vger.kernel.org>; Wed, 27 Apr 2011 17:50:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104270840190.27415@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

hi,sage
thanks for you answer. I have another problem, if i didn't set "max_siz=
e" ?
does that means i won't recvoery any data if client crashes?

2011/4/27 Sage Weil <sage@newdream.net>:
> On Wed, 27 Apr 2011, huang jun wrote:
>> hi,developers
>> =A0 when write a file, why did client send a message to mds to chang=
e
>> the variable "max_size" in inode =A0? so, if we don't change the
>> "max_size", what =A0consequence we =A0will get? and why the client w=
ill
>> not write if the mds didn't return the changed "max_size" to client?
>
> The max_size sets a bound on the number of data objects the client is
> allowed to write to, which in turn bounds the amount of work probing
> objects that MDS has to do if the client crashes to recover the file =
size
> and mtime.
>
> Setting it larger will let the client write more data faster, but wil=
l
> mean more work if the client crashes.
>
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
