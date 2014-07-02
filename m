From: Koleos Fuscus <koleosfuscus@gmail.com>
Subject: Re: state model diagram
Date: Thu, 3 Jul 2014 00:24:46 +0200
Message-ID: <CACUN8h3gyDNsr=hSqPi1ufu8bT08_0rR510bbaA2Pd3Zm_qArw@mail.gmail.com>
References: <CACUN8h3uudxbkxBNQYZX8_UV1WYOXfBjoivBGCZJhO4N2yZdKA@mail.gmail.com>
	<53B2F022.1060002@dachary.org>
	<alpine.DEB.2.00.1407021225090.24420@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:62188 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbaGBWYq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jul 2014 18:24:46 -0400
Received: by mail-ie0-f173.google.com with SMTP id at20so2501122iec.18
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jul 2014 15:24:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407021225090.24420@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello all,

Thanks for the comments. It is true, the state model has too many
details. I don=E2=80=99t see such level of detailed in the current code=
,
something that I fully agree. As the original author said, we need to
=E2=80=9Cassert only failure cases with statistically interesting
consequences=E2=80=9D. But, I did a diagram for two reasons: 1) get an =
overall
idea of how and when the process related with detecting and repairing
errors are launched and 2) see if other reliability models may apply
to the ceph case.

Overall, I think the figure is much better than the diagram published
in http://ceph.com/docs/firefly/dev/peering/ that triggered me to do
sth about it. Initially, I was trying to understand the peering
process and all the things that happen when a OSD fails the peering.
In future, I would like to have a better version and maybe include it
in the paper.

Best

koleosfuscus

________________________________________________________________
"My reply is: the software has no known bugs, therefore it has not
been updated."
Wietse Venema


On Wed, Jul 2, 2014 at 9:28 PM, Sage Weil <sweil@redhat.com> wrote:
> Hi Koleofuscus, Loic,
>
> I see several minor inaccuracies on that diagram, but my main questio=
n
> (like Loic) is whether they are relevant for the reliability model.
>
> For example, backfill and 'remap and get sync' are more or less equiv=
alent
> (tho backfill is missing the 'delete stray replicas' state after); it=
 make
> little difference from a durability perspective whether it is the pri=
mary
> or a replica that fails unless you are watching the messages go by.  =
And I
> think the exceptional cases (unfound objects) can be simplified.
>
> sage
>
>
> On Tue, 1 Jul 2014, Loic Dachary wrote:
>
>>
>> Hi koleofuscus,
>>
>> I took a look at
>> https://wiki.ceph.com/Development/Add_erasure_coding_to_the_durabili=
ty_model/Technical_details_on_the_model
>> and it makes sense to me. However I wonder why you would want to go =
into
>> that level of detail ? Could you point me where you would encode suc=
h
>> details events in the current code ?
>>
>> Cheers
>>
>> On 26/06/2014 02:29, Koleos Fuscus wrote:
>> > Hi,
>> >
>> > I found a state model diagram in the page that explains peering
>> > (http://ceph.com/docs/firefly/dev/peering/). The image cannot be
>> > visualised correctly. I build the docs and could open the image in=
 an
>> > appropriate size using graphviz but still the layout is too comple=
x
>> > and messy.
>> > I decided to do my own state model to collaborate in the understan=
ding
>> > of ceph. Actually, it helps me to measure my own understanding of =
the
>> > system. Using the diagram facilitates the decision of modeling one
>> > event or skip another. You can find the diagram here:
>> > https://wiki.ceph.com/Development/Add_erasure_coding_to_the_durabi=
lity_model/Technical_details_on_the_model
>> >
>> > Please give me your comments.
>> >
>> > koleosfuscus
>> >
>> > ________________________________________________________________
>> > "My reply is: the software has no known bugs, therefore it has not
>> > been updated."
>> > Wietse Venema
>> >
>>
>> --
>> Lo?c Dachary, Artisan Logiciel Libre
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
