From: Gregory Farnum <greg@inktank.com>
Subject: Re: [EXTERNAL] Re: avoiding false detection of down OSDs
Date: Tue, 31 Jul 2012 11:14:55 -0700
Message-ID: <CAPYLRzg6=xc0ib=Wdv96TzuCYWdw6zbUSVWvvYPPNp0_ExpW9g@mail.gmail.com>
References: <CAPYLRzjoaWkMkz4U+=rZQ+YMS76vkLf_KVZfbWmdLnPuCYadSw@mail.gmail.com>
	<50170EF0.5040004@sandia.gov>
	<CAPYLRzhH-MNPHhXbg36jkMGGdh3mtn+jqR5FQDzGta0y67UkPw@mail.gmail.com>
	<5017F4CC.9070308@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47830 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755414Ab2GaSO5 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Jul 2012 14:14:57 -0400
Received: by lahd3 with SMTP id d3so4198002lah.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 11:14:55 -0700 (PDT)
In-Reply-To: <5017F4CC.9070308@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>, Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jul 31, 2012 at 8:07 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 07/30/2012 06:24 PM, Gregory Farnum wrote:
>> Hmm. The concern is that if an OSD is stuck on disk swapping then it=
's
>> going to be just as stuck for the monitors as the OSDs =97 they're a=
ll
>> using the same network in the basic case, etc. We want to be able to
>> make that guess before the OSD is able to answer such questions.
>> But I'll think on if we could try something else similar.
>
>
> OK - thanks.
>
> Also, FWIW I've been running my Ceph servers with no swap,
> and I've recently doubled the size of my storage cluster.
> Is it possible to have map processing do a little memory
> accounting and log it, or to provide some way to learn
> that map processing is chewing up significant amounts of
> memory?  Or maybe there's already a way to learn this that
> I need to learn about?  I sometimes run into something that
> shares some characteristics with what you describe, but is
> primarily triggered by high client write load.  I'd like
> to be able to confirm or deny it's the same basic issue
> you've described.

I think that we've done all our diagnosis using profiling tools, but
there's now a map cache and it probably wouldn't be too difficult to
have it dump data via perfcounters if you poked around...anything like
this exist yet, Sage?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
