From: Yehuda Sadeh-Weinraub <yehuda-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: rgw: how to prevent rgw user from creating a new
	bucket?
Date: Fri, 2 Dec 2016 08:13:30 -0800
Message-ID: <CADRKj5Rt6gDPXwQH9UivgWhLRqzbzVD7VECogU7iTmKUAihBHg@mail.gmail.com>
References: <584158A2.9020303@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <584158A2.9020303-/BaA95PH9wJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Yang Joseph <joseph.yang-/BaA95PH9wJWk0Htik3J/w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Javen Wu <javen.wu-/BaA95PH9wJWk0Htik3J/w@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Dec 2, 2016 at 3:18 AM, Yang Joseph <joseph.yang-/BaA95PH9wJWk0Htik3J/w@public.gmane.org> wrote:
> Hello,
>
> I would like only to allow the user to read the object in a already existed
> bucket, and not allow users
> to create new bucket. It supposed to execute the following command:
>
> $ radosgw-admin metadata put user:test3 < ...
>   ...
>         "caps": [
>             {
>                 "type": "buckets",
>                 "perm": "read"
>             }
>
> But why user test3 can still create new bucket after I have set its caps to
> "buckets=read"?
>


Because this cap is unrelated. iirc starting at jewel you can do:

$ radosgw-admin user modify --uid=test3 --max-buckets=-1

Yehuda
