From: Gregory Farnum <greg@inktank.com>
Subject: Re: issues with adjusting the crushmap in 0.51
Date: Thu, 6 Sep 2012 11:19:12 -0700
Message-ID: <CAPYLRzggLqcgvMJWFDYOsHvQNK2oOvHmmTEnufK60R4=mdEQNw@mail.gmail.com>
References: <20120906175821.GA32205@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50532 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196Ab2IFSTN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Sep 2012 14:19:13 -0400
Received: by ieje11 with SMTP id e11so3549134iej.19
        for <ceph-devel@vger.kernel.org>; Thu, 06 Sep 2012 11:19:12 -0700 (PDT)
In-Reply-To: <20120906175821.GA32205@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: ceph-devel@vger.kernel.org

On Thu, Sep 6, 2012 at 10:58 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
> Hi All,
>
> I've been playing around with 0.51 of ceph on two test machines in
> work, I was experimenting with adjusting the crushmap to change from
> replicating across osd's to replicating across hosts. When I change
> the rule for my data pool from type osd to type host, compile up the
> crushmap and then a "ceph osd setcrushmap -i crush.new" it crashes my
> monitor if I have one running, if I have two, then one of them crashes
> and the process just hangs and leaves my test filesystem in an unclean
> state.
>
> I changed the rule data {} to this
>
> rule data {
>         ruleset 0
>         type replicated
>         min_size 1
>         max_size 10
>         step take default
>         step choose firstn 0 type host
>         step emit
> }
>
> Are there any constraints for changing the rules on where things get
> replicated? i.e. to go from osd to host to rack with the data and
> metadata?

You always need to end up with "devices" (the OSDs, generally) and
then emit those from your CRUSH rule. You can do so hierarchically:
rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step choose firstn 0 type host
        step choose firstn 1 osd
        step emit
}
In this case, (with n being your replication count) this rule chooses
n hosts, and then chooses 1 OSD from each chosen host.

You can also use "chooseleaf", which is a bit more robust in the
presence of failed OSDs:
rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}
This rule will choose n hosts and an OSD from each chosen host, and if
it fails on any host then it will restart with a different host (the
previous rule would stick with the chosen hosts and so it can't handle
if eg an entire host's OSDs are down).
-Greg
