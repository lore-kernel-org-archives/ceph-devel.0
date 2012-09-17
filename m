From: Wido den Hollander <wido@widodh.nl>
Subject: Re: How to use ruleset
Date: Mon, 17 Sep 2012 17:04:17 +0200
Message-ID: <50573BF1.4010001@widodh.nl>
References: <CAGfy=6=6P1zA-0gkBqEowuuiP0qqCjnFpGCSM-R0xKBL13W7uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:45915 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab2IQPEU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Sep 2012 11:04:20 -0400
In-Reply-To: <CAGfy=6=6P1zA-0gkBqEowuuiP0qqCjnFpGCSM-R0xKBL13W7uQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 09/17/2012 11:42 AM, hemant surale wrote:
> Hi Community,
>
>           I have read the documentation to know crush map as well as
> inserting new crushmap, But I have qn that even after writing own rule
> for data placement how we can apply it for data placement? in short
> how to utilize newly specified rule when new data insertion is
> executed.
>

Every rule has a "ruleset" ID which is an integer, like:

rule data {
         ruleset 0
         ...
         ...
}

Every pool has an attribute called "crush_ruleset 0".

So if you change the ruleset in the crushmap it will re-distribute all 
the data according to the new rule. New data will be placed according to 
this new ruleset.

If you created a NEW ruleset you should create a new pool like this:

$ rados mkpool mynewpool 0 4

See --help for more information.

This should however get you going.

Wido

>          Currently I am using "rados -p <poolname> put/get Objname
> filename" cmd to put/get data into ceph.
>
> Thanks for helping me out till now.
>
>
>
> Regards,
> Hemant Surale.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

