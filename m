From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: rest mgmt api
Date: Wed, 6 Feb 2013 10:15:05 -0800
Message-ID: <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:55566 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab3BFSPH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 13:15:07 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so1947094iag.3
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 10:15:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 6, 2013 at 9:25 AM, Sage Weil <sage@inktank.com> wrote:
> One of the goals for cuttlefish is to improvement manageability of the
> system.  This will invovle both cleaning up the CLI and adding a REST API
> to do everything the CLI current does.  There are a few implementation
> choices to make.
>
> Currenty the 'ceph' tool has a bunch of code to send messages to the
> monitor and wait for replies.  This is 90% of what users currently can do.
> For the most part, the commands are interpreted by the monitor.  A small
> subset of commands (ceph tell ..., ceph pg <pgid> ...) will send commands
> directory to OSDs.
>
>
> There are two main options for a REST endpoint that we've discussed so
> far:
>
> 1- Wrap the above in a clean library (probably integrating most of the
> code into Objecter/MonClient.. see wip-monc for a start on this).  Wrap
> libcephadmin in python and make a simple HTTP/REST front-end.  Users would
> deploy mgmt endpoints in addition to/alongside monitors and everything
> else.  If they want the rest api at all.
>
> 2- Embed a web server in the ceph-mon daemons, and push the current admin
> 'client' functionality there.  Come up with some basic authentication so
> that this doesn't break the current security model.

I'm in favor of the more modular and flexible approach, #1.

>
> Note that neither of these solves the HA issue directly; HTTP is a
> client/server protocol, so whoever is using the API can specify only one
> server endpoint.  If it is a monitor, they'll need to be prepare to fail
> over to another in their code, or set up a load balancer.  Same goes for
> the restful endpoint, if it fails.  The difference is that a single
> endpoint can proxy to whichever monitors are in quorum, so a much smaller
> set of errors (endpoint machine crash, buggy endpoint) affect availability
> of the API.

Right. However, that's really an orthogonal issue. It'll be easier
scaling the HTTP endpoints if they're decoupled from the monitors.

>
>
> The somewhat orthogonal question is how to clean up the CLI usage,
> parsing, and get equivalence in the new REST API.
>
> One option is to create a basic framework in the monitor so that there is
> a table of api commands.  The 'parsing' would be regularized and validated
> in a generic way.  The rest endpoint would pass the URI through in a
> generic way (sanitized json?) that can be matched against the same table.
>
> Another option is to support a single set of commands on the monitor side,
> and do the REST->CLI or CLI->REST or CLI,REST->json translation on the
> client side.  The command registry framework above would live in the CLI
> utility and REST endpoints instead (or libcephadmin).  This means that the
> monitor code is simpler, but also means that the libcephadmin or ceph tool
> and REST endpoint need to be running the latest code to be able to send
> the latest commands to the monitor.  It also means multiple places where
> the command set is defined (mon and endpoint and cli).

I'd rather keep the clients dumb, not involve them with the actual
configuration logic. Will make our lives easier in the long run.

>
> Either way there is a fair bit of refactoring, but it should be a net
> cleanup.  I'd like to get some consensus on how to proceed before we
> expend too much effort.  Ian scheduled a quick chat Friday, so let's get
> any other suggestions or ideas out before then so we can move forward...
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
