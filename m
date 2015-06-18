From: Milan Broz <mbroz@redhat.com>
Subject: Re: Interested in ceph OSD encryption and key management
Date: Thu, 18 Jun 2015 15:34:42 +0200
Message-ID: <5582C8F2.2010604@redhat.com>
References: <1432787005.11787.33.camel@catalyst.net.nz> <alpine.DEB.2.00.1505281257490.6462@cobra.newdream.net> <1434508656.26942.19.camel@catalyst.net.nz> <alpine.DEB.2.00.1506162115350.16406@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59059 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755985AbbFRNep (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 18 Jun 2015 09:34:45 -0400
In-Reply-To: <alpine.DEB.2.00.1506162115350.16406@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Andrew Bartlett <abartlet@catalyst.net.nz>
Cc: ceph-devel@vger.kernel.org

On 06/17/2015 06:16 AM, Sage Weil wrote:
>>> The wiki logins are broken, but ignore that.. we're moving to 
>>> tracker.ceph.com's wiki shortly anyway.  Email is best in the meantime!
>>
>> This proposal seems not have to have it to the new wiki.  Is it still
>> alive?  What do we need to do to keep this moving?

I am not able to even login to wiki, seems logins are still completely broken.
Probably nobody can edit it now?

> I can create a placeholder session.  Can you two hash out a proposal over 
> the next week or so to discuss?  I think there are some tricky questions 
> if petera is used if we want it to integrate with the monitors as well 
> (e.g., leverage the monitors for updating/distributing the petera 
> certs/keys).

Yes, but later please. We have a lot of fun with selinux and other things,
this feature could follow later.

BTW Petera is now renamed to Deo (and should be in Fedora packaged already).

The idea was:

- use LUKS as the encryption format

- use Deo to map OSD, for more info see
  https://github.com/npmccallum/deo

  In short, Deo will connect to MON node and negotiate key and directly
  unlock LUKS device.
  (New version now uses libcryptsetup direcly, so it is really one client binary.)

  There must be a service listening on MONs nodes (Deo server).

  I have no idea yet how problematic will be handling certificates here, but
  because it ensures authentication and encrypts communication, it seems like
  a nice design.

  Anyway, delegating this task to one simple tool (maintained independently
  of Ceph) is IMHO a good idea and the whole integration should not be complicated.
  (Moreover it will allow easy integration with FreeIPA and similar tools later.)

Milan

