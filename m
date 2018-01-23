From: Ricardo Dias <rdias@suse.com>
Subject: Re: debugging mgr python modules
Date: Tue, 23 Jan 2018 07:30:43 +0000
Message-ID: <60075fa9-f114-649c-b49b-217087f33e89@suse.com>
References: <822b6122-c866-f6b6-42e5-6913dbef0744@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:45831 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeAWHbO (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 23 Jan 2018 02:31:14 -0500
In-Reply-To: <822b6122-c866-f6b6-42e5-6913dbef0744@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Serong <tserong@suse.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 23-01-2018 00:38, Tim Serong wrote:
> Hi All,
> 
> Right now, if you want to debug an mgr python module, you're pretty much
> restricted to dumping interesting stuff to log files, right?
> 
> What about if you wanted to run an interactive python debugger?
> 
> I had two half-formed ideas for this.  One is that apparently there's
> something called prdb, which could theoretically be loaded in an mgr
> module to enable remote debugging over a socket (although
> https://pypi.python.org/pypi/rpdb/ says it reroutes stdout and stdin,
> which I assume might not work given mgr is already eating those -- not
> sure, haven't had a chance to try it yet).

Even without having the stdout/err it's very useful to be able to stop 
execution at breakpoints and do a step-by-step execution. I think it 
should be easy to make prdb to work with ceph-mgr plugins. Thanks for 
the research.

> 
> The second idea was to create a python wrapper which provides a stub
> implementation of the pieces that ceph-mgr exposes from C++ land
> (ceph_state, etc.).  This would expose some fake cluster state, much as
> the minion sim thing did in calamari.  Then you could (somehow) load/run
> a mgr python module completely outside mgr to experimentally poke at it.
>   Having typed all that out  now, I suspect this might be a PITA to
> maintain and be ultimately less useful for live debugging that the first
> half-formed idea, although it might be interesting for unit testing.

I think this idea is also very useful but for a different use-case like 
unit/functional testing without having to start a Ceph cluster.
This way we could add unit tests to the ceph-mgr plugins and run them 
along with the already existing tests.

> 
> Any thoughts on whether any of the above is worth pursuing?
> 
> Thanks,
> 
> Tim
> 

-- 
Ricardo Dias
Senior Software Engineer - Storage Team
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284
(AG Nürnberg)
