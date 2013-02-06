From: Dan Mick <dan.mick@inktank.com>
Subject: Re: rest mgmt api
Date: Wed, 06 Feb 2013 11:22:55 -0800
Message-ID: <5112AD8F.2030009@inktank.com>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:57416 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247Ab3BFTW7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 14:22:59 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so1988963iak.38
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 11:22:58 -0800 (PST)
In-Reply-To: <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org



On 02/06/2013 10:15 AM, Yehuda Sadeh wrote:
> On Wed, Feb 6, 2013 at 9:25 AM, Sage Weil <sage@inktank.com> wrote:
>> One of the goals for cuttlefish is to improvement manageability of the
>> system.  This will invovle both cleaning up the CLI and adding a REST API
>> to do everything the CLI current does.  There are a few implementation
>> choices to make.
>>
>> Currenty the 'ceph' tool has a bunch of code to send messages to the
>> monitor and wait for replies.  This is 90% of what users currently can do.
>> For the most part, the commands are interpreted by the monitor.  A small
>> subset of commands (ceph tell ..., ceph pg <pgid> ...) will send commands
>> directory to OSDs.
>>
>>
>> There are two main options for a REST endpoint that we've discussed so
>> far:
>>
>> 1- Wrap the above in a clean library (probably integrating most of the
>> code into Objecter/MonClient.. see wip-monc for a start on this).  Wrap
>> libcephadmin in python and make a simple HTTP/REST front-end.  Users would
>> deploy mgmt endpoints in addition to/alongside monitors and everything
>> else.  If they want the rest api at all.
>>
>> 2- Embed a web server in the ceph-mon daemons, and push the current admin
>> 'client' functionality there.  Come up with some basic authentication so
>> that this doesn't break the current security model.
>
> I'm in favor of the more modular and flexible approach, #1.

The more I think about it, the more I am too.  I can imagine admin 
flexibility being key: not just redundancy/failover, but also access 
perms, and the more independent the REST channel is from the normal auth 
channels, the better, I think.

>> Note that neither of these solves the HA issue directly; HTTP is a
>> client/server protocol, so whoever is using the API can specify only one
>> server endpoint.  If it is a monitor, they'll need to be prepare to fail
>> over to another in their code, or set up a load balancer.  Same goes for
>> the restful endpoint, if it fails.  The difference is that a single
>> endpoint can proxy to whichever monitors are in quorum, so a much smaller
>> set of errors (endpoint machine crash, buggy endpoint) affect availability
>> of the API.
>
> Right. However, that's really an orthogonal issue. It'll be easier
> scaling the HTTP endpoints if they're decoupled from the monitors.

and easier to rewrite/redeploy, and authenticate, etc.

>> The somewhat orthogonal question is how to clean up the CLI usage,
>> parsing, and get equivalence in the new REST API.
>>
>> One option is to create a basic framework in the monitor so that there is
>> a table of api commands.  The 'parsing' would be regularized and validated
>> in a generic way.  The rest endpoint would pass the URI through in a
>> generic way (sanitized json?) that can be matched against the same table.
>>
>> Another option is to support a single set of commands on the monitor side,
>> and do the REST->CLI or CLI->REST or CLI,REST->json translation on the
>> client side.  The command registry framework above would live in the CLI
>> utility and REST endpoints instead (or libcephadmin).  This means that the
>> monitor code is simpler, but also means that the libcephadmin or ceph tool
>> and REST endpoint need to be running the latest code to be able to send
>> the latest commands to the monitor.  It also means multiple places where
>> the command set is defined (mon and endpoint and cli).
>
> I'd rather keep the clients dumb, not involve them with the actual
> configuration logic. Will make our lives easier in the long run.

Yes, and I really really want to simplify/table-ify the command parsing 
code.
