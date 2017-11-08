From: David Galloway <dgallowa@redhat.com>
Subject: Re: Redmine problem
Date: Wed, 8 Nov 2017 16:55:50 -0500
Message-ID: <e83efaf2-e811-df08-ccf5-84ec516e7131@redhat.com>
References: <7f49bc39-c717-273e-c2d2-adade2df172e@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751049AbdKHVzv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Nov 2017 16:55:51 -0500
In-Reply-To: <7f49bc39-c717-273e-c2d2-adade2df172e@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Dachary, Loic" <loic@dachary.org>


On 11/08/2017 04:54 PM, Nathan Cutler wrote:
> Hi David:
> 
> In order to automate creation of backport tracker issues, we use a tool
> written by Loic that is essentially a glorified python script. It has
> worked flawlessly for years. Today, all of a sudden, it started failing
> with
> 
> requests.exceptions.ConnectionError: ('Connection aborted.', error(104,
> 'Connection reset by peer'))
> 
> This error message is emanating from the python-requests module, which
> is used to communicate with Redmine (probably via its REST API) over
> http. Apparently, the other side (i.e. tracker.ceph.com) is resetting
> the connection without warning.
> 
> Did something change recently on the server side? Like, in the last two
> or three days? If so, I'm curious to hear what, since it would probably
> help me to debug this issue.
> 

Could it possibly be because Loic no longer has Redmine Administrator
privileges per his request?
