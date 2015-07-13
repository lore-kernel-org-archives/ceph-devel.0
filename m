From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Strange issue with CRUSH
Date: Mon, 13 Jul 2015 11:28:07 -0500
Message-ID: <55A3E717.5080604@redhat.com>
References: <CAOWwpMJv4N0BvdEy2Y-WpDqqZ6R=f_5_+2j1dWeVe-Xk1fg1bQ@mail.gmail.com>	<alpine.DEB.2.00.1507091501570.20547@cobra.newdream.net>	<1736665041.43352077.1436482991363.JavaMail.zimbra@redhat.com>	<55A3D720.7070006@redhat.com>	<CAOWwpMKN3YtACUj181K2Wqg539EibuUfh5UZPceoYr2rBLxOEQ@mail.gmail.com> <CAOWwpMKeQyx+PQdNMqGvXAtamg4mMGSZrEw96X9D5KWGnaQa9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56979 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140AbbGMQ2K (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Jul 2015 12:28:10 -0400
In-Reply-To: <CAOWwpMKeQyx+PQdNMqGvXAtamg4mMGSZrEw96X9D5KWGnaQa9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gleb Borisov <borisov.gleb@gmail.com>
Cc: Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Looking at the output, it looks like even pool 19 has a pretty small 
number of PGs for that many OSDs:

+----------------------------------------------------------------------------+
| Pool ID: 19 |
+----------------------------------------------------------------------------+
| Participating OSDs: 1056 |
| Participating PGs: 16404 |
+----------------------------------------------------------------------------+ 


And as you say, the distribution looks a little better than a totally 
random distribution:

| OSDs in All Roles (Up) |
| Expected PGs Per OSD: Min: 20, Max: 71, Mean: 46.6, Std Dev: 12.7 |
| Actual PGs Per OSD: Min: 24, Max: 69, Mean: 46.6, Std Dev: 6.9 |
| 5 Most Subscribed OSDs: 791(69), 977(69), 211(68), 536(67), 37(65) |
| 5 Least Subscribed OSDs: 1074(24), 1042(28), 215(29), 139(30), 205(30) |

But there's still a lot of variance between the most and least 
subscribed OSDs.  It's worse if you look at OSDs acting in a primary 
role (ie servicing reads):

| OSDs in Primary Role (Up) |
| Expected PGs Per OSD: Min: 0, Max: 29, Mean: 15.5, Std Dev: 7.4 |
| Actual PGs Per OSD: Min: 5, Max: 32, Mean: 15.5, Std Dev: 3.8 |
| 5 Most Subscribed OSDs: 606(32), 211(30), 1065(27), 956(26), 228(25) |
| 5 Least Subscribed OSDs: 317(5), 550(5), 215(6), 473(6), 19(7) |

It may be worth increasing the PG count for that pool at least!

Mark


On 07/13/2015 11:11 AM, Gleb Borisov wrote:
> Hi,
>
> Forget about exponential distribution. It was kind of raving of a madman
> :) seems that it's really uniform.
>
>
> I run tool mentioned above and saved output to gist:
> https://gist.github.com/anonymous/d228fe9340825f33310b
>
> We've one big pool for rgw (19) and several smaller pools (control pools
> and few for testing) and also have two roots (default with 1056 osds and
> ssd_default with 30 osds).
>
> It seems that our distribution is slightly better than expected in your
> code.
>
> Thanks.
>
> On Mon, Jul 13, 2015 at 7:11 PM, Gleb Borisov <borisov.gleb@gmail.com
> <mailto:borisov.gleb@gmail.com>> wrote:
>  >
>  > Hi,
>  >
>  > Forget about exponential distribution. It was kind of raving of a
> madman :) seems that it's really uniform.
>  >
>  >
>  > I run tool mentioned above and saved output to gist:
> https://gist.github.com/anonymous/d228fe9340825f33310b
>  >
>  > We've one big pool for rgw (19) and several smaller pools (control
> pools and few for testing) and also have two roots (default with 1056
> osds and ssd_default with 30 osds).
>  >
>  > It seems that our distribution is slightly better than expected in
> your code.
>  >
>  > Thanks.
>  >
>  > On Mon, Jul 13, 2015 at 6:20 PM, Mark Nelson <mnelson@redhat.com
> <mailto:mnelson@redhat.com>> wrote:
>  >>
>  >> FWIW,
>  >>
>  >> It would be very interesting to see the output of:
>  >>
>  >> https://github.com/ceph/cbt/blob/master/tools/readpgdump.py
>  >>
>  >> If you see something that looks anomalous.  I'd like to make sure
> that I'm detecting issues like this.
>  >>
>  >> Mark
>  >>
>  >>
>  >> On 07/09/2015 06:03 PM, Samuel Just wrote:
>  >>>
>  >>> I've seen some odd teuthology in the last week or two which seems
> to be anomalous rjenkins hash behavior as well.
>  >>>
>  >>> http://tracker.ceph.com/issues/12231
>  >>> -Sam
>  >>>
>  >>> ----- Original Message -----
>  >>> From: "Sage Weil" <sweil@redhat.com <mailto:sweil@redhat.com>>
>  >>> To: "Gleb Borisov" <borisov.gleb@gmail.com
> <mailto:borisov.gleb@gmail.com>>
>  >>> Cc: ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.kernel.org>
>  >>> Sent: Thursday, July 9, 2015 3:06:00 PM
>  >>> Subject: Re: Strange issue with CRUSH
>  >>>
>  >>> On Fri, 10 Jul 2015, Gleb Borisov wrote:
>  >>>>
>  >>>> Hi Sage,
>  >>>>
>  >>>> Sorry for mailing you in person, I realize that you're quite busy
> at redhat,
>  >>>> but I wanted you have a look on an issue with CRUSH map.
>  >>>
>  >>>
>  >>> No problem. I hope you don't mind I've added ceph-devel to the cc list.
>  >>>
>  >>>> I've described very first insights here:
>  >>>>
> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2015-July/002897.html
>  >>>>
>  >>>> We are continue our research and found that distribution of PG
> count by OSD
>  >>>> is very strange and after digging into CRUSH source code found
> rjenkins1
>  >>>> hash function.
>  >>>>
>  >>>> After some testing we realized that rjenkins1's value distribution is
>  >>>> exponential, and this can cause our disbalance.
>  >>>
>  >>>
>  >>> Any issue with rjenkins1's hash function is very interesting and
>  >>> concerning.  Can you describe your analysis and what you mean by the
>  >>> distribution being exponential?
>  >>>
>  >>>> What do you think about adding additional hashing algorithm to
> CRUSH? It
>  >>>> seems that it could improve distribution.
>  >>>
>  >>>
>  >>> I am definitely open to adding new hash functions, especially if the
>  >>> current ones are flawed.  The current hash was created by making ad hoc
>  >>> combinations of rjenkins' mix function with various numbers of
>  >>> arguments--hardly scientific or methodical.  We did an analysis a
> couple
>  >>> years back and found that it effectively modeled a uniform
> distribution,
>  >>> but if we missed something or were wrong we should definitely
> correct it!
>  >>>
>  >>> In any case, the important step is to quantify what is wrong with the
>  >>> current hash so that we can ensure any new one is not flawed in the
> same
>  >>> way.
>  >>>
>  >>> Thanks-
>  >>> sage
>  >>>
>  >>>
>  >>>> We have also tried to generate some syntetic crushmaps (another bucket
>  >>>> types, more OSDs per host, more/less hosts by rack, different cound of
>  >>>> racks, linear osd ids, random osd ids, etc), but didn't found any
>  >>>> combination with better distribution of PG across OSD.
>  >>>>
>  >>>> Thanks and one more sorry for bothering you in person.
>  >>>> --
>  >>>> Best regards,
>  >>>> Gleb M Borisov
>  >>>>
>  >>>>
>  >>> --
>  >>> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
>  >>> the body of a message to majordomo@vger.kernel.org
> <mailto:majordomo@vger.kernel.org>
>  >>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>  >>>
>  >>> --
>  >>> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
>  >>> the body of a message to majordomo@vger.kernel.org
> <mailto:majordomo@vger.kernel.org>
>  >>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>  >>>
>  >
>  >
>  >
>  > --
>  > Best regards,
>  > Gleb M Borisov
>
>
>
>
> --
> Best regards,
> Gleb M Borisov
