From: Dan Mick <dan.mick@inktank.com>
Subject: Re: understanding cephx
Date: Thu, 17 Jan 2013 13:31:25 -0800
Message-ID: <50F86DAD.6040904@inktank.com>
References: <20130114161746.57302w31pt6asj2y@webmail.uni-tuebingen.de> <20130116104746.68482f92jla41zr6@webmail.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:62110 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab3AQVb2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 16:31:28 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1288322dak.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 13:31:28 -0800 (PST)
In-Reply-To: <20130116104746.68482f92jla41zr6@webmail.uni-tuebingen.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Menge <michael.menge@zdv.uni-tuebingen.de>
Cc: ceph-devel@vger.kernel.org

Glad you got it working!  Sorry for missing your original message..

On 01/16/2013 01:47 AM, Michael Menge wrote:
> Quoting Michael Menge <michael.menge@zdv.uni-tuebingen.de>:
>
>>
>> So i guess, by trying to get some more informations I somehow
>> manged to delete the mon. key. I was unable the retieve the history
>> because of the full filesystem.
>>
>> So I tried to use "ceph auth" and ceph-authtool to (re-)add the mon.=
 key
>> but only managed that mon.d is now too unable the authenticate.
>>
>
> I was able to insert the mon. key by receating the mon servers
>
> ceph auth get mon. -o /tmp/monkey.new
> ceph mon getmap -o /tmp/monmap.new
> ceph-mon -i d --mkfs --monmap /tmp/monmap.new --keyring /tmp/monkey.n=
ew
>
> Restarting the mon server didn't seem to have worked at first.
> Restarting with --debug_mon 10 showed that I was too impatient
> as the mon server had to update his mdsmap which took quiet some time
>
> Regards
>
>     Michael Menge
>
> ---------------------------------------------------------------------=
-----------
>
>
> M.Menge                                Tel.: (49) 7071/29-70316
> Universit=E4t T=FCbingen                   Fax.: (49) 7071/29-5912
> Zentrum f=FCr Datenverarbeitung          mail:
> michael.menge@zdv.uni-tuebingen.de
> W=E4chterstra=DFe 76
> 72074 T=FCbingen
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
