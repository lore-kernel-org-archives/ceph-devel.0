From: Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: OSD error
Date: Tue, 8 Dec 2015 17:21:17 -0500 (EST)
Message-ID: <126717427.39833269.1449613277107.JavaMail.zimbra@redhat.com>
References: <CY1PR0401MB130769FE58332BD9B7170043B8080@CY1PR0401MB1307.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CY1PR0401MB130769FE58332BD9B7170043B8080-6V1NFqo50e5/JycaaC2BN/nBZW37Ciw+nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan Nica <dan.nica-9LVeefAf2bFulyBr/6WiFlaTQe2KTcn/@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

+ceph-devel

----- Original Message ----- 

> From: "Dan Nica" <dan.nica-9LVeefAf2bFulyBr/6WiFlaTQe2KTcn/@public.gmane.org>
> To: ceph-users-Qp0mS5GaXlQ@public.gmane.org
> Sent: Tuesday, 8 December, 2015 7:54:20 PM
> Subject: [ceph-users] OSD error

> Hi guys,

> Recently I installed ceph cluster version 9.2.0, and on my osd logs I see
> these errors:

> 2015-12-08 04:49:12.931683 7f42ec266700 -1 lsb_release_parse - pclose failed:
> (13) Permission denied
> 2015-12-08 04:49:12.955264 7f42ec266700 -1 lsb_release_parse - pclose failed:
> (13) Permission denied

> Do I have to worry about it ? what is generating these errors ?

Dan, What does "lsb_release -idrc" return on this system?

I wonder if we are getting hit with EINTR here maybe and getting SIGPIPE?

static void lsb_release_parse(map<string, string> *m, CephContext *cct)
{
  FILE *fp = popen("lsb_release -idrc", "r");
  if (!fp) {
    int ret = -errno;
    lderr(cct) << "lsb_release_parse - failed to call lsb_release binary with error: " << cpp_strerror(ret) << dendl;
    return;
  }

  char buf[512];
  while (fgets(buf, sizeof(buf) - 1, fp) != NULL) {
    if (lsb_release_set(buf, "Distributor ID:", m, "distro"))
      continue;
    if (lsb_release_set(buf, "Description:", m, "distro_description"))
      continue;
    if (lsb_release_set(buf, "Release:", m, "distro_version"))
      continue;
    if (lsb_release_set(buf, "Codename:", m, "distro_codename"))
      continue;

    lderr(cct) << "unhandled output: " << buf << dendl;
  }

  if (pclose(fp)) {
    int ret = -errno;
    lderr(cct) << "lsb_release_parse - pclose failed: " << cpp_strerror(ret) << dendl;   <----------HERE
  }
}

Cheers,
Brad
