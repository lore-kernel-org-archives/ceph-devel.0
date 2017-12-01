From: Wido den Hollander <wido@42on.com>
Subject: Re: Integers as String in osd_metadata (memory, rotational)
Date: Fri, 1 Dec 2017 10:35:35 +0100 (CET)
Message-ID: <1727800240.5825.1512120936215@ox.pcextreme.nl>
References: <83609177.5513.1511867211100@ox.pcextreme.nl>
 <CALe9h7foTN+tfM4n07AwS6iOLzRyFOFi-NTLMMV1=_FPHVHamA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se02-out.mail.pcextreme.nl ([185.66.251.201]:52101 "EHLO
        se02-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751322AbdLAJfq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Dec 2017 04:35:46 -0500
In-Reply-To: <CALe9h7foTN+tfM4n07AwS6iOLzRyFOFi-NTLMMV1=_FPHVHamA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 28 november 2017 om 12:53 schreef John Spray <jspray@redhat.com>:
> 
> 
> On Tue, Nov 28, 2017 at 11:06 AM, Wido den Hollander <wido@42on.com> wrote:
> > Hi,
> >
> > Looking at 'ceph osd metadata' I see that we return a lot of values as Strings in the JSON instead of a Integer, for example:
> >
> > $ ceph osd metadata 2033
> >
> > {
> >     "id": 2033,
> >     "arch": "x86_64",
> >     "journal_rotational": "0",
> >     "mem_swap_kb": "1046524",
> >     "mem_total_kb": "63641808",
> >     "rotational": "1"
> > }
> >
> > Looking at some code I found this:
> >
> > (*m)["mem_total_kb"] = std::to_string(size);
> > (*pm)["rotational"] = store_is_rotational ? "1" : "0";
> > (*pm)["journal_rotational"] = journal_is_rotational ? "1" : "0";
> >
> > Why can't we return a int/long there? Is it the internal JSON parser which can't handle it?
> 
> There are various places where we send metadata as map<string, string>
> (in this instance, MOSDBoot), which is indeed kind of annoying --
> converting them all to a JSON-ish structure would be a good thing.
> 

Yes, or at least have a difference between int and string.

> I'm imagining a helper class that wraps boost::property_tree and slots
> in everywhere we currently use map<string, string> for metadata.
> 

That is slightly out of my comfort zone. I wouldn't know where to start :-)

Wido

> John
> 
> > Otherwise I'll write a PR for this. Saves me casting the things to Integers again afterwards in Python.
> >
> > Wido
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
