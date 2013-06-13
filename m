From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: rbd rm <image> results in osd marked down wrongly
 with 0.61.3
Date: Thu, 13 Jun 2013 07:59:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306130753200.21994@cobra.newdream.net>
References: <51B731F7.2050002@smart-weblications.de>
	<51B9BA40.6040901@smart-weblications.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <51B9BA40.6040901-o+pLhCRhXQuTURD7UP6EnqXJknND6eY5@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Smart Weblications GmbH - Florian Wiessner <f.wiessner-o+pLhCRhXQuTURD7UP6EnqXJknND6eY5@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi Florian,

Sorry, I missed this one.  Since this is fully reproducible, can you 
generate a log of the crash by doing something like

 ceph osd tell \* injectargs '--debug-osd 20 --debug-filestore 20 --debug-ms 20'

(that is a lot of logging, btw), triggering a crash, and then sending us 
the log on the failed osd?  You'll want to turn the logs down again after 
with

 ceph osd tell \* injectargs '--debug-osd 0 --debug-filestore 0 --debug-ms 0'

I've opened a ticket for this,

Thanks!
sage


On Thu, 13 Jun 2013, Smart Weblications GmbH - Florian Wiessner wrote:

> Hi,
> 
> Is really no one on the list interrested in fixing this? Or am i the only one
> having this kind of bug/problem?
> 
> Am 11.06.2013 16:19, schrieb Smart Weblications GmbH - Florian Wiessner:
> > Hi List,
> > 
> > i observed that an rbd rm <image> results in some osds mark one osd as down
> > wrongly in cuttlefish.
> > 
> > The situation gets even worse if there are more than one rbd rm <image> running
> > in parallel.
> > 
> > Please see attached logfiles. The rbd rm command was issued on 20:24:00 via
> > cronjob, 40 seconds later the osd 6 got marked down...
> > 
> > 
> > ceph osd tree
> > 
> > # id    weight  type name       up/down reweight
> > -1      7       pool default
> > -3      7               rack unknownrack
> > -2      1                       host node01
> > 0       1                               osd.0   up      1
> > -4      1                       host node02
> > 1       1                               osd.1   up      1
> > -5      1                       host node03
> > 2       1                               osd.2   up      1
> > -6      1                       host node04
> > 3       1                               osd.3   up      1
> > -7      1                       host node06
> > 5       1                               osd.5   up      1
> > -8      1                       host node05
> > 4       1                               osd.4   up      1
> > -9      1                       host node07
> > 6       1                               osd.6   up      1
> > 
> > 
> > I have seen some patches to parallelize rbd rm, but i think there must be some
> > other issue, as my clients seem to not be able to do IO when ceph is
> > recovering... I think this has worked better in 0.56.x - there was IO while
> > recovering.
> > 
> > I also observed in the log of osd.6 that after heartbeat_map reset_timeout, the
> > osd tries to connect to the other osds, but it retries so fast that you could
> > think this is a DoS attack...
> > 
> > 
> > Please advise..
> > 
> 
> 
> -- 
> 
> Mit freundlichen Gr??en,
> 
> Florian Wiessner
> 
> Smart Weblications GmbH
> Martinsberger Str. 1
> D-95119 Naila
> 
> fon.: +49 9282 9638 200
> fax.: +49 9282 9638 205
> 24/7: +49 900 144 000 00 - 0,99 EUR/Min*
> http://www.smart-weblications.de
> 
> --
> Sitz der Gesellschaft: Naila
> Gesch?ftsf?hrer: Florian Wiessner
> HRB-Nr.: HRB 3840 Amtsgericht Hof
> *aus dem dt. Festnetz, ggf. abweichende Preise aus dem Mobilfunknetz
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
