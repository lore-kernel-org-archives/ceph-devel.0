From: Jan Fajerski <jfajerski-IBi9RG/b67k@public.gmane.org>
Subject: Re: Show and Tell: Grafana cluster dashboard
Date: Mon, 7 May 2018 14:21:38 +0200
Message-ID: <20180507122138.pqsw3gfjn3x4j33f@jf_suse_laptop>
References: <328d036f-87be-c85f-1d48-605edb3a0c63@univie.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <328d036f-87be-c85f-1d48-605edb3a0c63-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Kurt Bauer <kurt.bauer-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, May 07, 2018 at 02:05:59PM +0200, Kurt Bauer wrote:
>   Hi Jan,
>   first of all thanks for this dashboard.
>   A few comments:
>   -) 'vonage-status-panel' is needed, which isn't mentioned in the ReadMe
Yes, my bad. Will update the README
>   -) Using ceph 12.2.4 the mon metric for me is apparently called
>   'ceph_mon_quorum_count' not 'ceph_mon_quorum_status'
I'll also add to the readme: The dashboard is based on Ceph Mimic.
>   And a question:
>   Is there a way to get the Cluster IOPS with prometheus metrics? I did
>   this with collectd, but can't find a suitable metric from ceph-mgr.
Yes...at least in Mimic the metrics are called ceph_osd_op[_r,_w,_rw]
>   Best regards,
>   Kurt
>
>   [1]Jan Fajerski
>   7. May 2018 at 12:32
>
>   Hi all,
>   I'd like to request comments and feedback about a Grafana dashboard for
>   Ceph cluster monitoring.
>   [2]https://youtu.be/HJquM127wMY
>   [3]https://github.com/ceph/ceph/pull/21850
>   The goal is to eventually have a set of default dashboards in the Ceph
>   repository that offer decent monitoring for clusters of various (maybe
>   even all) sizes and applications, or at least serve as a starting point
>   for customizations.
>   --
>   To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>   in
>   the body of a message to [4]majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>   More majordomo info at  [5]http://vger.kernel.org/majordomo-info.html
>
>References
>
>   1. mailto:jfajerski-IBi9RG/b67k@public.gmane.org
>   2. https://youtu.be/HJquM127wMY
>   3. https://github.com/ceph/ceph/pull/21850
>   4. mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>   5. http://vger.kernel.org/majordomo-info.html

>_______________________________________________
>ceph-users mailing list
>ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


-- =

Jan Fajerski
Engineer Enterprise Storage
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton,
HRB 21284 (AG N=FCrnberg)
