From: Sage Weil <sweil@redhat.com>
Subject: Re: state model diagram
Date: Wed, 2 Jul 2014 12:28:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407021225090.24420@cobra.newdream.net>
References: <CACUN8h3uudxbkxBNQYZX8_UV1WYOXfBjoivBGCZJhO4N2yZdKA@mail.gmail.com> <53B2F022.1060002@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47554 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbaGBT2z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jul 2014 15:28:55 -0400
In-Reply-To: <53B2F022.1060002@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Koleos Fuscus <koleosfuscus@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Koleofuscus, Loic,

I see several minor inaccuracies on that diagram, but my main question 
(like Loic) is whether they are relevant for the reliability model.

For example, backfill and 'remap and get sync' are more or less equivalent 
(tho backfill is missing the 'delete stray replicas' state after); it make 
little difference from a durability perspective whether it is the primary 
or a replica that fails unless you are watching the messages go by.  And I 
think the exceptional cases (unfound objects) can be simplified.

sage


On Tue, 1 Jul 2014, Loic Dachary wrote:

> 
> Hi koleofuscus,
> 
> I took a look at 
> https://wiki.ceph.com/Development/Add_erasure_coding_to_the_durability_model/Technical_details_on_the_model 
> and it makes sense to me. However I wonder why you would want to go into 
> that level of detail ? Could you point me where you would encode such 
> details events in the current code ?
> 
> Cheers
> 
> On 26/06/2014 02:29, Koleos Fuscus wrote:
> > Hi,
> > 
> > I found a state model diagram in the page that explains peering
> > (http://ceph.com/docs/firefly/dev/peering/). The image cannot be
> > visualised correctly. I build the docs and could open the image in an
> > appropriate size using graphviz but still the layout is too complex
> > and messy.
> > I decided to do my own state model to collaborate in the understanding
> > of ceph. Actually, it helps me to measure my own understanding of the
> > system. Using the diagram facilitates the decision of modeling one
> > event or skip another. You can find the diagram here:
> > https://wiki.ceph.com/Development/Add_erasure_coding_to_the_durability_model/Technical_details_on_the_model
> > 
> > Please give me your comments.
> > 
> > koleosfuscus
> > 
> > ________________________________________________________________
> > "My reply is: the software has no known bugs, therefore it has not
> > been updated."
> > Wietse Venema
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
