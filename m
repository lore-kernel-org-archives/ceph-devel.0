From: Dan van der Ster <daniel.vanderster-vJEk5272eHo@public.gmane.org>
Subject: Re: full osdmaps in mon txns
Date: Mon, 5 Jan 2015 10:12:10 +0100
Message-ID: <CABZ+qqk9dW2eHnECci31xe6W0LvVUhZyiZc9ainCEqAEOtPd3g@mail.gmail.com>
References: <alpine.DEB.2.00.1412231306170.28630@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1412231306170.28630-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Sage,

On Tue, Dec 23, 2014 at 10:10 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> This fun issue came up again in the form of 10422:
>
>         http://tracker.ceph.com/issues/10422
>
> I think we have 3 main options:
>
> 1. Ask users to do a mon scrub prior to upgrade to
> ensure it is safe.  If a mon is out of sync, manually kick it out, blow it
> away, and resync.
>

I just tried ceph scrub on a cluster we already upgraded from dumpling
to firefly:

2015-01-05 09:44:32.811194 mon.0 137.138.13.136:6789/0 622509 : [ERR]
scrub mismatch
2015-01-05 09:44:32.811289 mon.0 137.138.13.136:6789/0 622510 : [ERR]
mon.0 ScrubResult(keys
{auth=90,logm=1163,mdsmap=3,monmap=5,osdmap=1541,pgmap=645,pgmap_meta=6,pgmap_osd=208,pgmap_pg=24704}
crc {auth=2819756818,logm=2322364559,mdsmap=183360962,monmap=2103930516,osdmap=522825856,pgmap=2035077624,pgmap_meta=951037946,pgmap_osd=3980602023,pgmap_pg=502660406})
2015-01-05 09:44:32.811414 mon.0 137.138.13.136:6789/0 622511 : [ERR]
mon.2 ScrubResult(keys
{auth=90,logm=1163,mdsmap=3,monmap=5,osdmap=1541,pgmap=645,pgmap_meta=6,pgmap_osd=208,pgmap_pg=24704}
crc {auth=2819756818,logm=2322364559,mdsmap=183360962,monmap=2103930516,osdmap=3364575095,pgmap=2035077624,pgmap_meta=951037946,pgmap_osd=3980602023,pgmap_pg=502660406})

Is this the same issue as #10422? What would you do to recover?

Cheers, and Happy New Year!

Dan


>
> 2. Do a one-time broadcast of the full osdmap across mons to ensure they
> are consistent after upgrade.  Bleh.
>
> 3. Include full encoded OSDMap in txns on updates going forward.
>
> I like 3 because it solves this and all related problems going forward.
> The local encoding of full osdmaps has proven to be a huge headache.
> And, the patch to do it is remarkably simple
>
>         https://github.com/ceph/ceph/pull/3247/files
>
> and dovetails well with the new CRC.
>
> What do you think?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
