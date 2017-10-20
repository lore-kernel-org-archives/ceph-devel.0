From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Why does messenger sends the address of himself and of the
 connecting peer
Date: Fri, 20 Oct 2017 11:30:40 -0400
Message-ID: <CA+aFP1DXBphFN4DddcE-nsnnmzcd4L1DLuq+wPzD29FSaWt+-Q@mail.gmail.com>
References: <1508513118.10018.8.camel@suse.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:50096 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdJTPal (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Oct 2017 11:30:41 -0400
Received: by mail-yw0-f171.google.com with SMTP id z195so226410ywz.6
        for <ceph-devel@vger.kernel.org>; Fri, 20 Oct 2017 08:30:41 -0700 (PDT)
In-Reply-To: <1508513118.10018.8.camel@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <rdias@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I had a similar question when I got hit by clients behind a NAT
failing to connect [1] to the cluster.

[1] http://tracker.ceph.com/issues/20049

On Fri, Oct 20, 2017 at 11:25 AM, Ricardo Dias <rdias@suse.com> wrote:
> Hi,
>
> In the current messenger protocol, upon accepting a new connection, the
> messenger sends it's address and the connecting peer address along with
> the banner string. Why does the connecting peer need these addresses?
> Moreover, the connecting peer uses the connecting peer address (sent
> from the server) to set as it's own address.
>
> What happens if the network is rewriting addresses  because of NAT, or
> whatever other strange reasons?
>
> I also saw that the code that encodes these addresses have a comment
> saying "// legacy". Should we remove these addresses from the new V2
> protocol, or do we still need them?
>
> Thanks,
> Ricardo
>
> --
> Ricardo Dias
> Senior Software Engineer - Storage Team
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
> HRB 21284
> (AG Nürnberg)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
