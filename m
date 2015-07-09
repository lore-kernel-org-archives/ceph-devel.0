From: Owen Synge <osynge@suse.com>
Subject: Re: python facade pattern implementation in ceph and ceph-deploy
 is bad practice?
Date: Thu, 09 Jul 2015 18:28:55 +0200
Message-ID: <559EA147.8090201@suse.com>
References: <559E4814.8030007@suse.com> <559E50F2.7030801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:40906 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbbGIQas (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 9 Jul 2015 12:30:48 -0400
In-Reply-To: <559E50F2.7030801@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, ceph-devel@vger.kernel.org, Loic Dachary <loic@dachary.org>, Travis Rhoden <trhoden@redhat.com>

Dear all,

Lets put a positive spin on this thread and set all misunderstandings on
my side :)

I propose that John clarified and I misunderstood the others in upstream
ceph-deploy's position, the style guide includes:

(0) Opposes duplication of code.
(1) Opposes duplication of code for each platform making up more than a
minimum of code.
(2) Allowing the use of objects in python.
(3) Allowing the use of objects with properties.
(4) Allowing the use of some standard design patterns not already in
ceph-deploy.
(5) Allowing that a change in style (such as use of 3 objects in a
facade) has to be propagated in all parts of ceph and tested for all
platforms before they can reach master even if the migration can be staged.

Hopefully this can be agreed.

On 07/09/2015 12:46 PM, John Spray wrote:

> I had not seen your wip_services_abstraction branch before, I've just
> taken a quick look now.  More comments would probably have made it
> easier to read, as would following PEP8.  I don't think there's anything
> problematic about having a class that knows how to start and stop a
> service, but I don't know what comments you've received elsewhere (there
> aren't any on the PR).

If this is not agreeable to all, please speak up.

Best regards

Owen
