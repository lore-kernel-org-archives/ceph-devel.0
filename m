From: Allen Samuels <Allen.Samuels-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Deprecating ext4 support
Date: Mon, 11 Apr 2016 21:42:13 +0000
Message-ID: <CY1PR0201MB1897BE8035001D8D15151EBBE8940@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1604111632520.13448-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>, "ceph-announce-Qp0mS5GaXlQ@public.gmane.org" <ceph-announce-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

RIP ext4.


Allen Samuels
Software Architect, Fellow, Systems and Software Solutions 

2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels-BhnZeUuC+ExBDgjK7y7TUQ@public.gmane.org


> -----Original Message-----
> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ceph-devel-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Sage Weil
> Sent: Monday, April 11, 2016 2:40 PM
> To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org; ceph-
> maintainers-Qp0mS5GaXlQ@public.gmane.org; ceph-announce-Qp0mS5GaXlQ@public.gmane.org
> Subject: Deprecating ext4 support
> 
> Hi,
> 
> ext4 has never been recommended, but we did test it.  After Jewel is out,
> we would like explicitly recommend *against* ext4 and stop testing it.
> 
> Why:
> 
> Recently we discovered an issue with the long object name handling that is
> not fixable without rewriting a significant chunk of FileStores filename
> handling.  (There is a limit in the amount of xattr data ext4 can store in the
> inode, which causes problems in LFNIndex.)
> 
> We *could* invest a ton of time rewriting this to fix, but it only affects ext4,
> which we never recommended, and we plan to deprecate FileStore once
> BlueStore is stable anyway, so it seems like a waste of time that would be
> better spent elsewhere.
> 
> Also, by dropping ext4 test coverage in ceph-qa-suite, we can significantly
> improve time/coverage for FileStore on XFS and on BlueStore.
> 
> The long file name handling is problematic anytime someone is storing rados
> objects with long names.  The primary user that does this is RGW, which
> means any RGW cluster using ext4 should recreate their OSDs to use XFS.
> Other librados users could be affected too, though, like users with very long
> rbd image names (e.g., > 100 characters), or custom librados users.
> 
> How:
> 
> To make this change as visible as possible, the plan is to make ceph-osd
> refuse to start if the backend is unable to support the configured max
> object name (osd_max_object_name_len).  The OSD will complain that ext4
> cannot store such an object and refuse to start.  A user who is only using
> RBD might decide they don't need long file names to work and can adjust
> the osd_max_object_name_len setting to something small (say, 64) and run
> successfully.  They would be taking a risk, though, because we would like
> to stop testing on ext4.
> 
> Is this reasonable?  If there significant ext4 users that are unwilling to
> recreate their OSDs, now would be the time to speak up.
> 
> Thanks!
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
