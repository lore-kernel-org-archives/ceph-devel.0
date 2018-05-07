From: Kurt Bauer <kurt.bauer-4JhlDu4IDl0juwv8T7myQQ@public.gmane.org>
Subject: Re: Show and Tell: Grafana cluster dashboard
Date: Mon, 7 May 2018 14:05:59 +0200
Message-ID: <328d036f-87be-c85f-1d48-605edb3a0c63@univie.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2740887714854613430=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
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
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============2740887714854613430==
Content-Type: multipart/alternative;
 boundary="------------4DAEA3E00727C0F24E6439CE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------4DAEA3E00727C0F24E6439CE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

first of all thanks for this dashboard.
A few comments:
-) 'vonage-status-panel' is needed, which isn't mentioned in the ReadMe
-) Using ceph 12.2.4 the mon metric for me is apparently called 
'ceph_mon_quorum_count' not 'ceph_mon_quorum_status'

And a question:
Is there a way to get the Cluster IOPS with prometheus metrics? I did 
this with collectd, but can't find a suitable metric from ceph-mgr.

Best regards,
Kurt

> Jan Fajerski <mailto:jfajerski-IBi9RG/b67k@public.gmane.org>
> 7. May 2018 at 12:32
> Hi all,
> I'd like to request comments and feedback about a Grafana dashboard 
> for Ceph cluster monitoring.
>
> https://youtu.be/HJquM127wMY
>
> https://github.com/ceph/ceph/pull/21850
>
> The goal is to eventually have a set of default dashboards in the Ceph 
> repository that offer decent monitoring for clusters of various (maybe 
> even all) sizes and applications, or at least serve as a starting 
> point for customizations.
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--------------4DAEA3E00727C0F24E6439CE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head><body text="#000000" bgcolor="#FFFFFF">Hi Jan,<br>
<br>
first of all thanks for this dashboard.<br>
A few comments:<br>
-) 'vonage-status-panel' is needed, which isn't mentioned in the ReadMe<br>
-) Using ceph 12.2.4 the mon metric for me is apparently called 
'ceph_mon_quorum_count' not 'ceph_mon_quorum_status'<br>
<br>
And a question:<br>
Is there a way to get the Cluster IOPS with prometheus metrics? I did 
this with collectd, but can't find a suitable metric from ceph-mgr.<br>
<br>
Best regards,<br>
Kurt<br>
<span>

</span><br>
<blockquote type="cite" 
cite="mid:20180507103229.j6rlyohnhejq3cnb@jf_suse_laptop" style="border:
 0px none ! important;">
  <div xmlns="http://www.w3.org/1999/xhtml" class="__pbConvHr" 
style="margin:30px 25px 10px 25px;"><div 
style="width:100%;border-top:2px solid #EDF1F4;padding-top:10px;">   <div
 
style="display:inline-block;white-space:nowrap;vertical-align:middle;width:49%;">
   	<a style="color:#485664 
!important;padding-right:6px;font-weight:500;text-decoration:none 
!important;" href="mailto:jfajerski-IBi9RG/b67k@public.gmane.org" moz-do-not-send="true">Jan
 Fajerski</a></div>   <div 
style="display:inline-block;white-space:nowrap;vertical-align:middle;width:48%;text-align:
 right;">     <font color="#909AA4"><span style="padding-left:6px">7. 
May 2018 at 12:32</span></font></div>    </div></div>
  <div xmlns="http://www.w3.org/1999/xhtml" class="__pbConvBody" 
__pbrmquotes="true" 
style="color:#909AA4;margin-left:24px;margin-right:24px;">Hi all,
<br>I'd like to request comments and feedback about a Grafana dashboard 
for Ceph 
cluster monitoring.
<br>
<br><a class="moz-txt-link-freetext" href="https://youtu.be/HJquM127wMY">https://youtu.be/HJquM127wMY</a>
<br>
<br><a class="moz-txt-link-freetext" href="https://github.com/ceph/ceph/pull/21850">https://github.com/ceph/ceph/pull/21850</a>
<br>
<br>The goal is to eventually have a set of default dashboards in the 
Ceph 
repository that offer decent monitoring for clusters of various (maybe 
even all) 
sizes and applications, or at least serve as a starting point for 
customizations.
<br>--
<br>To unsubscribe from this list: send the line "unsubscribe 
ceph-devel" in
<br>the body of a message to <a class="moz-txt-link-abbreviated" href="mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>
<br>More majordomo info at  <a class="moz-txt-link-freetext" href="http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org/majordomo-info.html</a>
<br>

  </div>
</blockquote>
</body></html>

--------------4DAEA3E00727C0F24E6439CE--

--===============2740887714854613430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============2740887714854613430==--
