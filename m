From: mdw-Jp3n8lUXroRWk0Htik3J/w@public.gmane.org
Subject: Re: Intel 520/530 SSD for ceph
Date: Wed, 20 Nov 2013 19:29:36 -0500
Message-ID: <20131121002936.GA15558@soma.private.linuxbox.com>
References: <528A1862.7010601@profihost.ag>
	<20131118225146.GA1043@soma.private.linuxbox.com>
	<528B1B21.1060203@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528B1B21.1060203-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 19, 2013 at 09:02:41AM +0100, Stefan Priebe wrote:
...
> >You might be able to vary this behavior by experimenting with sdparm,
> >smartctl or other tools, or possibly with different microcode in the drive.
> Which values or which settings do you think of?
...

Off-hand, I don't know.  Probably the first thing would be
to compare the configuration of your 520 & 530; anything that's
different is certainly worth investigating.

This should display all pages,
	sdparm --all --long /dev/sdX
the 520 only appears to have 3 pages, which can be fetched directly w/
	sdparm --page=ca --long /dev/sdX
	sdparm --page=co --long /dev/sdX
	sdparm --page=rw --long /dev/sdX

The sample machine I'm looking has an intel 520, and on ours,
most options show as 0 except for
  AWRE        1  [cha: n, def:  1]  Automatic write reallocation enabled
  WCE         1  [cha: y, def:  1]  Write cache enable
  DRA         1  [cha: n, def:  1]  Disable read ahead
  GLTSD       1  [cha: n, def:  1]  Global logging target save disable
  BTP        -1  [cha: n, def: -1]  Busy timeout period (100us)
  ESTCT      30  [cha: n, def: 30]  Extended self test completion time (sec)
Perhaps that's an interesting data point to compare with yours.

Figuring out if you have up-to-date intel firmware appears to require
burning and running an iso image from
https://downloadcenter.intel.com/Detail_Desc.aspx?agr=Y&DwnldID=18455

The results of sdparm --page=<whatever> --long /dev/sdc
show the intel firmware, but this labels it better:
smartctl -i /dev/sdc
Our 520 has firmware "400i" loaded.

				-Marcus Watts
