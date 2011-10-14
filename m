From: Jojy Varghese <jojy.varghese@gmail.com>
Subject: Re: [PATCH 1/3] mds:Interval tree
Date: Thu, 13 Oct 2011 21:28:30 -0700
Message-ID: <CAJD3hpXq3E9QismM2rbrYozxwBkTV8TfGg8ziY9FZLpXrUxZ7A@mail.gmail.com>
References: <CAJD3hpWY0F-qg05Tgzy5twpcqJSQXAcAEs_yv7qTzFTxAWW33w@mail.gmail.com>
	<CAJD3hpXCO2uut-ftpFgOr7=vnE60g6_oeT2hmDy9QDo1d6n6Xw@mail.gmail.com>
	<Pine.LNX.4.64.1110132034120.16643@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53777 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455Ab1JNE2b convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Oct 2011 00:28:31 -0400
Received: by ggnb1 with SMTP id b1so21978ggn.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2011 21:28:30 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1110132034120.16643@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Great. Are there any unit test cases for the lock subsytem?


thanks
Jojy


On Thu, Oct 13, 2011 at 8:35 PM, Sage Weil <sage@newdream.net> wrote:
> Hi Jojy-
>
> I merged this into the tree. =C2=A0The next step is to redo the flock=
 code to
> use this. =C2=A0Should be much cleaner...
>
> Thanks!
> sage
>
>
> On Tue, 11 Oct 2011, Jojy Varghese wrote:
>
>> Hi
>> =C2=A0 I am resending the patch series for interval set. This time I=
 have
>> integrated the unit test cases to the existing suite.
>>
>> =C2=A0 This patch-series of 3 patches has following changes:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Interval tree implementation
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Unit test cases for the implementation
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Makefile changes for unit test integrat=
ion
>>
>>
>> Interval tree is an optimized data structure for =C2=A0representing =
and
>> querying intervals. Elementary intervals are
>> represented as nodes of an avl tree and the corresponding data =C2=A0=
is
>> stored on these nodes based on a concept of span.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 This representation allows log(n) (where=
 n is the number of
>> data) storage. The balanced avl tree allows a log(n) query.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 The implementation is a template class t=
hat is instantiated
>> based on parameters :
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - Interval type
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 - Data type
>>
>> =C2=A0 This is a basic component which can be used to store byte ran=
ge locks.
>>
>>
>> thanks
>> -Jojy
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
