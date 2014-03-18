From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: firefly timing
Date: Tue, 18 Mar 2014 17:20:30 +0100
Message-ID: <F2392340-9DC1-4ABA-9CC4-CED5B85F7CC6@profihost.ag>
References: <alpine.DEB.2.00.1403172115140.24236@cobra.newdream.net>
	<5327F0A7.8010105@profihost.ag>
	<alpine.DEB.2.00.1403180905500.316@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1403180905500.316-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


> Am 18.03.2014 um 17:06 schrieb Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> 
>> On Tue, 18 Mar 2014, Stefan Priebe - Profihost AG wrote:
>> Hi Sage,
>> 
>> i really would like to test the tiering. Is there any detailed
>> documentation about it and how it works?
> 
> Great!  Here is a quick synopiss on how to set it up:
> 
>    http://ceph.com/docs/master/dev/cache-pool/

What I'm missing is a documentation about the cache settings?

> 
> sage
> 
> 
> 
>> 
>> Greets,
>> Stefan
>> 
>> Am 18.03.2014 05:45, schrieb Sage Weil:
>>> Hi everyone,
>>> 
>>> It's taken longer than expected, but the tests for v0.78 are calming down 
>>> and it looks like we'll be able to get the release out this week.
>>> 
>>> However, we've decided NOT to make this release firefly.  It will be a 
>>> normal development release.  This will be the first release that includes 
>>> some key new functionality (erasure coding and cache tiering) and although 
>>> it is passing our tests we'd like to have some operational experience with 
>>> it in more users' hands before we commit to supporting it long term.
>>> 
>>> The tentative plan is to freeze and then release v0.79 after a normal two 
>>> week cycle.  This will serve as a 'release candidate' that shaves off a 
>>> few rough edges from the pending release (including some improvements with 
>>> the API for setting up erasure coded pools).  It is possible that 0.79 
>>> will turn into firefly, but more likely that we will opt for another two 
>>> weeks of hardening and make 0.80 the release we name firefly and maintain 
>>> for the long term.
>>> 
>>> Long story short: 0.78 will be out soon, and you should test it!  It is 
>>> will vary from the final firefly in a few subtle ways, but any feedback or 
>>> usability and bug reports at this point will be very helpful in shaping 
>>> things.
>>> 
>>> Thanks!
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
