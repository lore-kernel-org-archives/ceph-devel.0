From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Flapping osd / continuously reported as failed
Date: Mon, 19 Aug 2013 15:19:20 -0700
Message-ID: <CAPYLRzjTmLG_DY4EbmDwndSg5x6ZBznbavxOoU_+Wxh1q8OcYg@mail.gmail.com>
References: <0D057B737C42FC4AB3F22773A5C9425F259DBDEDD0@MXMBON06.grupa.onet>
	<CAPYLRzjGDep1ny6K-Ctz_7VG4THV6nAx9odOdjr=WNNesV4cVA@mail.gmail.com>
	<0D057B737C42FC4AB3F22773A5C9425F259DBDEDD1@MXMBON06.grupa.onet>
	<CAPYLRzhVtMCY+-d-y5F5M5hMVDwRh343+bB7An4Xcw4DT3n82w@mail.gmail.com>
	<0D057B737C42FC4AB3F22773A5C9425F259DBDF026@MXMBON06.grupa.onet>
	<ADBDB4FFB0814748AF32D0A1EE6E10AF228296D145@MXMBON06.grupa.onet>
	<CAPYLRzghUwEvu_f0aV2Q37JqnyCJ=46cTWiteTwN4=Tmqxd3HA@mail.gmail.com>
	<ADBDB4FFB0814748AF32D0A1EE6E10AF228322C755@MXMBON06.grupa.onet>
	<CAPYLRzi8YLvg=sRq06QS3ju1gLxvCONucsOufhFjcbBPU2Av4A@mail.gmail.com>
	<ADBDB4FFB0814748AF32D0A1EE6E10AF228322C9F0@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C9F0-K9pFWFEelezFe27LHpJFGNHuzzzSOjJt@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Mostowiec Dominik <Dominik.Mostowiec-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>
Cc: =?ISO-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sydor Bohdan <Bohdan.Sydor-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Aug 19, 2013 at 3:09 PM, Mostowiec Dominik
<Dominik.Mostowiec-Yw1TE0hTT7dz6jiHbVrK7g@public.gmane.org> wrote:
> Hi,
>> Yes, it definitely can as scrubbing takes locks on the PG, which will prevent reads or writes while the message is being processed (which will involve the rgw index being scanned).
> It is possible to tune scrubbing config for eliminate slow requests and marking osd down when large rgw bucket index is scrubbing?

Unfortunately not, or we would have mentioned it before. :/ There are
some proposals for sharding bucket indexes that would ameliorate this
problem, and on Cuttlefish or Dumpling the OSD won't get marked down,
but it will still block incoming requests on that object (ie, requests
to access the bucket) while the scrubbing is in place.
That said, that improvement might be sufficient since you haven't
actually shown us how long the object scrub takes.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
