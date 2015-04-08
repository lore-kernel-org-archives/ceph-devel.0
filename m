From: Andrey Korolyov <andrey-5vqebrSIFTo@public.gmane.org>
Subject: Re: Preliminary RDMA vs TCP numbers
Date: Wed, 8 Apr 2015 11:28:12 +0300
Message-ID: <CABYiri_ihguSripu=gs-MA7Qr8GRDk7H5hw5BNKf-9OSFu1z8g@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD75D78@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD75D78-cXZ6iGhjG0il5HHZYNR2WTJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Apr 8, 2015 at 11:17 AM, Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi,
> Please find the preliminary performance numbers of TCP Vs RDMA (XIO) implementation (on top of SSDs) in the following link.
>
> http://www.slideshare.net/somnathroy7568/ceph-on-rdma
>
> The attachment didn't go through it seems, so, I had to use slideshare.
>
> Mark,
> If we have time, I can present it in tomorrow's performance meeting.
>
> Thanks & Regards
> Somnath
>

Those numbers are really impressive (for small numbers at least)! What
are TCP settings you using?For example, difference can be lowered on
scale due to less intensive per-connection acceleration on CUBIC on a
larger number of nodes, though I do not believe that it was a main
reason for an observed TCP catchup on a relatively flat workload such
as fio generates.
