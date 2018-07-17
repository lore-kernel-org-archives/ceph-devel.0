From: Stefan Kooman <stefan-68+x73Hep80@public.gmane.org>
Subject: Re: v12.2.7 Luminous released
Date: Tue, 17 Jul 2018 20:24:19 +0200
Message-ID: <20180717182419.GA1559@shell.dmz.bit.nl>
References: <87tvox968t.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87tvox968t.fsf-IBi9RG/b67k@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Quoting Abhishek Lekshmanan (abhishek-IBi9RG/b67k@public.gmane.org):

> *NOTE* The v12.2.5 release has a potential data corruption issue with
> erasure coded pools. If you ran v12.2.5 with erasure coding, please see
> below.

< snip >

> Upgrading from v12.2.5 or v12.2.6
> ---------------------------------
> 
> If you used v12.2.5 or v12.2.6 in combination with erasure coded
> pools, there is a small risk of corruption under certain workloads.
> Specifically, when:

< snip >

One section mentions Luminous clusters _with_ EC pools specifically, the other
section mentions Luminous clusters running 12.2.5. I might be
misreading this, but to make  things clear for current Ceph Luminous
12.2.5 users. Is the following statement correct?

If you do _NOT_ use EC in your 12.2.5 cluster (only replicated pools), there is
no need to quiesce IO (ceph osd pause).

http://docs.ceph.com/docs/master/releases/luminous/#upgrading-from-other-versions
If your cluster did not run v12.2.5 or v12.2.6 then none of the above
issues apply to you and you should upgrade normally.

^^ Above section would indicate all 12.2.5 luminous clusters.

Please clarify,

Thanks,

Stefan

-- 
| BIT BV  http://www.bit.nl/        Kamer van Koophandel 09090351
| GPG: 0xD14839C6                   +31 318 648 688 / info-68+x73Hep80@public.gmane.org
