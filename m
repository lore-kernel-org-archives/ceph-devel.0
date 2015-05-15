From: Tim Serong <tserong@suse.com>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Fri, 15 May 2015 13:27:25 +1000
Message-ID: <5555679D.6050903@suse.com>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com> <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net> <5488FC46.5080106@suse.com> <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net> <552C9182.5030605@suse.com> <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net> <552D3C74.2000104@redhat.com> <87bnip2u10.fsf@meteor.durcheinandertal.bofh> <553E07C7.8030905@suse.com> <alpine.DEB.2.00.1504270901250.5458@cobra.newdream.net> <55549206.3040008@suse.com> <alpine.DEB.2.00.1505140906400.10788@cobra.newdream.net> <CAANLjFpgivwxMhFLy4OcCxnJ_k5ssORCUm2r+BgtU+LEPQmvPw@mail.gmail.com> <alpine.DEB.2.00.1505140935020.10788@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:51283 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1423143AbbEOD1r (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 14 May 2015 23:27:47 -0400
In-Reply-To: <alpine.DEB.2.00.1505140935020.10788@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Robert LeBlanc <robert@leblancnet.us>
Cc: Gaudenz Steinlin <gaudenz@debian.org>, Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, cjwatson@debian.org, ceph-maintainers@ceph.com, Steven Timm <timm@fnal.gov>, Owen Synge <osynge@suse.com>

On 05/15/2015 02:41 AM, Sage Weil wrote:
> On Thu, 14 May 2015, Robert LeBlanc wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> On Thu, May 14, 2015 at 10:08 AM, Sage Weil  wrote:
>>> The above should have no impact on other distros where a fixed UID/GID
>>> is already set in the package.
>>
>> This sounds pretty reasonable to me!  Perhaps there can be a 'default'
>> (but still opt-in) uid that is reserved and won't conflict going forward,
>> but may conflict with legacy environments?  That at least minimizes
>> complexity/pain for fresh environments (which I suspect will
>> be the bulk of the install base)?
>>
>>
>> Since there is no guarantee, can we just default to the same UID/GID that wa
>> s received from Debian, or is there a known conflict in RH/Cent/SUSE/etc?
> 
> The Fedora UID is 167.
>   - fedora: 0-200 = fixed allocations
>   - debian: 100-999 = dynamically allocated
>   - suse: 100-499 = dyamically allocated system users
> 
> The Debian UID is likely to be 64045.
>   - fedora: undefined (1000-60000 = user accounts, nothing above that)
>   - debian: 60000-64999 = reserved fixed uids, dynamically created
>   - suse: undefined (1000-60000 = user accounts, nothing above that)
> 
> I'm not sure which is less likely: colliding with a dynamically allocated 
> system user (how many of those are there?)

Some random data: my openSUSE desktop system has about 35 dynamically
allocated system users.  Looking at my mostly-clean SLE 11 and SLE 12
test sytems, each seems to have about 10 dynamically allocated users,
although interestingly SLE 11 starts adding these from 100, and
increments, while SLE 12 seems to start at 499 and go backwards.

> or a regular user (64045 is a very large uid).

My earlier thought was "everyone should follow Debian because it's a
very large UID", but this is still risky because high ranges can
conflict with UID ranges chosen when using an LDAP, AD or other backend.
 I can't state a specific conflict, just that there are sites whose
chosen user UID ranges overlap.  This is actually a real issue; there
are sites that have all systems (i.e.: even their servers) running such
backends, because they need users, even the sysadmins, to log in as a
regular user using that backend (then `sudo` or whatever for admin work)
due to auditing/security policies.

Regards,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
