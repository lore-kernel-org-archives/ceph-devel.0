From: Mostowiec Dominik <Dominik.Mostowiec-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>
Subject: Re: Flapping osd / continuously reported as failed
Date: Fri, 16 Aug 2013 14:47:52 +0200
Message-ID: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C755@MXMBON06.grupa.onet>
References: <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD0@MXMBON06.grupa.onet>
	<CAPYLRzjGDep1ny6K-Ctz_7VG4THV6nAx9odOdjr=WNNesV4cVA@mail.gmail.com>
	<0D057B737C42FC4AB3F22773A5C9425F259DBDEDD1@MXMBON06.grupa.onet>
	<CAPYLRzhVtMCY+-d-y5F5M5hMVDwRh343+bB7An4Xcw4DT3n82w@mail.gmail.com>
	<0D057B737C42FC4AB3F22773A5C9425F259DBDF026@MXMBON06.grupa.onet>
	<ADBDB4FFB0814748AF32D0A1EE6E10AF228296D145@MXMBON06.grupa.onet>
	<CAPYLRzghUwEvu_f0aV2Q37JqnyCJ=46cTWiteTwN4=Tmqxd3HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAPYLRzghUwEvu_f0aV2Q37JqnyCJ=46cTWiteTwN4=Tmqxd3HA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: pl-PL
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: =?iso-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sydor Bohdan <Bohdan.Sydor-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,
Thanks for your response.

> It's possible, as deep scrub in particular will add a bit of load (it
> goes through and compares the object contents). 

It is possible that the scrubbing blocks access(RW or only W) to bucket index when check .dir... file?
When rgw index is very large I guess it take some time.

> Are you not having any
> flapping issues any more, and did you try and find when it started the
> scrub to see if it matched up with your troubles?

No, I didn't.
But on our second cluster with the same problem, disable scrubbing also helps.

> I'd be hesitant to turn it off as scrubbing can uncover corrupt
> objects etc, but you can configure it with the settings at
> http://ceph.com/docs/master/rados/configuration/osd-config-ref/#scrubbing.
> (Always check the surprisingly-helpful docs when you need to do some
> config or operations work!)

I think change config scrub timeout or interval don't full remove issues.
Change "osd deep scrub stride" to small value make scrubbing lightest?

--
Regards
Dominik
