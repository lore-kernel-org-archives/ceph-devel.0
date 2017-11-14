From: Sage Weil <sage@newdream.net>
Subject: Re: config on mons
Date: Tue, 14 Nov 2017 16:24:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711141624140.25212@piezo.novalocal>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal> <CAE_BDMLSLKw0+nvuibuFLQG8C2tVWw8UqtmevffQXjAd=becyg@mail.gmail.com> <CALe9h7dEru5XbHpNOpSbSd3O-7SB=8=-VkYLQYH5na8bA9AMtQ@mail.gmail.com> <0fc42e25-2944-e020-00f5-8ed56a9464b7@redhat.com>
 <CAFMfnwoD8q+kaF9BEDFpT71qAfb62cdbajrNboR9MbsWO_-=8Q@mail.gmail.com> <CALe9h7fqDsREGHE-v2tjNOpGHpB6qA51m6prE6+TXjORrXz8_Q@mail.gmail.com> <ea84cfd4-5405-d647-be63-1d259c5702e5@corp.ovh.com> <CALe9h7ezuNOrH4prN3oKHHmCaqD=z19rw5frj97hXX8T=gOm_w@mail.gmail.com>
 <116bccee-f119-7782-0c4b-f10c5dd60e35@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-348817628-1510676677=:25212"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:37316 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdKNQYi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 11:24:38 -0500
In-Reply-To: <116bccee-f119-7782-0c4b-f10c5dd60e35@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek@corp.ovh.com>
Cc: John Spray <jspray@redhat.com>, Kyle Bader <kyle.bader@gmail.com>, Mark Nelson <mnelson@redhat.com>, Christian Wuerdig <christian.wuerdig@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-348817628-1510676677=:25212
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 14 Nov 2017, Piotr Dałek wrote:
> On 17-11-14 12:36 PM, John Spray wrote:
> > On Tue, Nov 14, 2017 at 10:18 AM, Piotr Dałek <piotr.dalek@corp.ovh.com>
> > wrote:
> > > On 17-11-13 07:40 PM, John Spray wrote:
> > > > I imagine many users today are not so disciplined as to version
> > > > control their configs, but this is a good opportunity to push that as
> > > > the norm by building it in.
> > > 
> > > Using Ceph on any decent scale actually requires one to use at least 
> > > Puppet or similar tool, I wouldn't add any unnecessary complexity to 
> > > already complex code just because of novice users that are going to 
> > > have hard time using Ceph anyway once a disk breaks and needs to be 
> > > replaced, or when performance goes to hell because users are free to 
> > > create and remove snapshots every 5 minutes.
> > 
> > All of the experienced users were novice users once -- making Ceph
> > work well for those people is worthwhile.  It's not easy to build
> > things that are easy enough for a newcomer but also powerful enough
> > for the general case, but it is worth doing.
> > 
> > When we have to trade internal complexity vs. complexity at
> > interfaces, it's generally better to keep the interfaces simple.
> > Currently a Ceph cluster with 1000 OSDs has 1000 places to input the
> > configuration, and no one place that a person can ask "what is setting
> > X on my OSDs?".  Even when they look at a ceph.conf file, they can't
> > be sure that those are really the values in use (has the service
> > restarted since the file was updated?) or that they will ever be (are
> > they invalid values that Ceph will reject on load?).
> 
> Well, at least I understand now why my config diff patch
> (https://github.com/ceph/ceph/pull/18586) is not interesting to reviewers. ;)

Oh, I hadn't seen this.  (Don't read too much into a lack of reviews or
comments!) I like the diff local command, not sure about the file one.
I'm in the midst of rewriting a bunch of this code in a preparatory
cleanup for the other config changes... I'll post a PR with just the      
cleanup portions shortly.

I think the big question is whether we can go all-in on mon configs or
whether we need to maintain a traditional ceph.conf option as well.  I'm
of two minds here.  I think it's pretty straightforward to get the
transparency/reporting that John is after by making daemons report running
config but not necessarily pull mon configs... and we probably want/need
that anyway to allow e.g. 'ceph daemon <name> config ...' overrides, and
for the upgrade path.  I'm just worried about an ever-expanding menu of
options.

I can't simply throw up our hands and say this is out of scope and
administrators need to be able to handle this on their own.  I had this
attitude for a long time and as a result Ceph has a repuation for being
hard to install, hard to configure, and hard to manage.  This limits     
adoption, makes it easy for users to make mistakes, and hurts the project.
We can do better.  Lots of other projects and storage systems *do* do     
better.

Let's just be smart about what we implement so that we're solving the
usability and transparently problems and without hobbling power users.

sage

--8323329-348817628-1510676677=:25212--
