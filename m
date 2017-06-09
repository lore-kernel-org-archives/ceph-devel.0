From: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Subject: Re: removing cluster name support
Date: Fri, 9 Jun 2017 18:36:21 +0200
Message-ID: <CABZ+qq=UKuHYgv=QQHipMGAyKCpZj0wejZLEz=e+Bi+ZJ-sGzg@mail.gmail.com>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
	<5BCB72AC-A5E4-4CE3-BF6A-5164F4B64496@quantum.com>
	<alpine.DEB.2.11.1706081951440.23631@piezo.novalocal>
	<CAC-Np1wjRX99N4q69XfWY0m0fDETpRQZj5Hrgoe6kbrh7riE+A@mail.gmail.com>
	<CAMrEFZ62a7dToADh=-nbLy15Xx9=_mmJkmDjP-JY4mfarpd_5Q@mail.gmail.com>
	<CAKPXa=ZjsvhAMwdM9k47L4gaMGVispyJ7bMOyR7dVu0y7pb12A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAKPXa=ZjsvhAMwdM9k47L4gaMGVispyJ7bMOyR7dVu0y7pb12A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Vasu Kulkarni <vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: wes_dillingham-nRXb03v5zC6Vc3sceRu5cw@public.gmane.org, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Jun 9, 2017 at 5:58 PM, Vasu Kulkarni <vakulkar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Fri, Jun 9, 2017 at 6:11 AM, Wes Dillingham
> <wes_dillingham-nRXb03v5zC6Vc3sceRu5cw@public.gmane.org> wrote:
>> Similar to Dan's situation we utilize the --cluster name concept for our
>> operations. Primarily for "datamover" nodes which do incremental rbd
>> import/export between distinct clusters. This is entirely coordinated by
>> utilizing the --cluster option throughout.
>>
>> The way we set it up is that all clusters are actually named "ceph" on the
>> mons and osds etc, but the clients themselves get /etc/ceph/clusterA.conf
>> and /etc/ceph/clusterB.conf so that we can differentiate. I would like to
>> see the functionality of clients being able to specify which conf file to
>> read preserved.
>
> ceph.conf along with keyring file can stay in any location, the
> default location is /etc/ceph but one could use
> other location for clusterB.conf (
> http://docs.ceph.com/docs/jewel/rados/configuration/ceph-conf/ ), At
> least
> for client which doesn't run any daemon this should be sufficient to
> make it talk to different clusters.

So we start with this:

> ceph --cluster=flax health
HEALTH_OK

Then for example do:
> cd /etc/ceph/
> mkdir flax
> cp flax.conf flax/ceph.conf
> cp flax.client.admin.keyring flax/ceph.client.admin.keyring

Now this works:

> ceph --conf=/etc/ceph/flax/ceph.conf --keyring=/etc/ceph/flax/ceph.client.admin.keyring health
HEALTH_OK

So --cluster is just convenient shorthand for the CLI.

I guess it won't be the end of the world if you drop it, but would it
be so costly to keep that working? (CLI only -- no use-case for
server-side named clusters over here).

--
Dan
