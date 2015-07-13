From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Strange issue with CRUSH
Date: Mon, 13 Jul 2015 10:20:00 -0500
Message-ID: <55A3D720.7070006@redhat.com>
References: <CAOWwpMJv4N0BvdEy2Y-WpDqqZ6R=f_5_+2j1dWeVe-Xk1fg1bQ@mail.gmail.com> <alpine.DEB.2.00.1507091501570.20547@cobra.newdream.net> <1736665041.43352077.1436482991363.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42846 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbbGMPUD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Jul 2015 11:20:03 -0400
In-Reply-To: <1736665041.43352077.1436482991363.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: Gleb Borisov <borisov.gleb@gmail.com>, ceph-devel@vger.kernel.org

FWIW,

It would be very interesting to see the output of:

https://github.com/ceph/cbt/blob/master/tools/readpgdump.py

If you see something that looks anomalous.  I'd like to make sure that 
I'm detecting issues like this.

Mark

On 07/09/2015 06:03 PM, Samuel Just wrote:
> I've seen some odd teuthology in the last week or two which seems to be anomalous rjenkins hash behavior as well.
>
> http://tracker.ceph.com/issues/12231
> -Sam
>
> ----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: "Gleb Borisov" <borisov.gleb@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Thursday, July 9, 2015 3:06:00 PM
> Subject: Re: Strange issue with CRUSH
>
> On Fri, 10 Jul 2015, Gleb Borisov wrote:
>> Hi Sage,
>>
>> Sorry for mailing you in person, I realize that you're quite busy at redhat,
>> but I wanted you have a look on an issue with CRUSH map.
>
> No problem. I hope you don't mind I've added ceph-devel to the cc list.
>
>> I've described very first insights here:
>> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2015-July/002897.html
>>
>> We are continue our research and found that distribution of PG count by OSD
>> is very strange and after digging into CRUSH source code found rjenkins1
>> hash function.
>>
>> After some testing we realized that rjenkins1's value distribution is
>> exponential, and this can cause our disbalance.
>
> Any issue with rjenkins1's hash function is very interesting and
> concerning.  Can you describe your analysis and what you mean by the
> distribution being exponential?
>
>> What do you think about adding additional hashing algorithm to CRUSH? It
>> seems that it could improve distribution.
>
> I am definitely open to adding new hash functions, especially if the
> current ones are flawed.  The current hash was created by making ad hoc
> combinations of rjenkins' mix function with various numbers of
> arguments--hardly scientific or methodical.  We did an analysis a couple
> years back and found that it effectively modeled a uniform distribution,
> but if we missed something or were wrong we should definitely correct it!
>
> In any case, the important step is to quantify what is wrong with the
> current hash so that we can ensure any new one is not flawed in the same
> way.
>
> Thanks-
> sage
>
>
>> We have also tried to generate some syntetic crushmaps (another bucket
>> types, more OSDs per host, more/less hosts by rack, different cound of
>> racks, linear osd ids, random osd ids, etc), but didn't found any
>> combination with better distribution of PG across OSD.
>>
>> Thanks and one more sorry for bothering you in person.
>> --
>> Best regards,
>> Gleb M Borisov
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
