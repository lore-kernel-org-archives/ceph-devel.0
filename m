Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9962BEC55
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787147937; cv=none; b=ZdTpZonBMyCXHdzUSWMK6G8EL2zxiUNIvzfTTRgbJy9JJVZjiBhEh5mir8O8Jq82aGGDu1sz5+v1qj8X6jC5xCHLkWhA9vY8kDvRsvp7UB9yCC/uXhhO2pxzwIuwJatnwXdvi7vfJnChf4yHSksUz+zZ7Ip3obz4F4XYJdgej+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787147937; c=relaxed/simple;
	bh=gusaMllUpsW8EOw4y3KfJzk88f3riGWj7dFvXiE3/fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzGM6EzfqXgzNavQuE78dHvND8QybU4u7lxPY2rh7vx9QY+oaEYF1Ss3PaGmU+wdDBVWwR2CIvv4zvauLMyGs5zRn3TBSg9XYRDStbZCoou4yk5criC4qU1+qJE3WtGTkVZYl02RCIyCj7Eoy7XwBPO1MAO02gAknFC868VcUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=hxVA8JrC; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=nrsMogrR; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="hxVA8JrC";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="nrsMogrR"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JDQSG8452840
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 09:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=8vRL
	r4hq/jt7Wt345UaSKOCc6NzvTZqNK8PhHqFZ8lk=; b=hxVA8JrCJW3MqphT5Zcx
	Q577b2ez5YGKkBYHquIHxM89OQIr8JsCDiwBNghe3jvWBqd7Fq+F+2SUBM53+8Ob
	dXRX6beJiMxjeNC7c2jYtpemsRKcmxSKu49JFnBAi3fPY2zC1mA8nQPuQHltx2GB
	JVDrDXWnTDp7Fi58KbeFy96tFeQiGSGOB2Ru3A8k8JXb4YXdR5xf2Ox/s4TP+MNA
	V+MQjL5B0wX32vemNxFqKOZuQUYQFPRxXq2Qqhs6CaDzEoJ3yP4j3e9U5thVt4lZ
	YZvI4Mjcpkv9Kgel2zfoBca8Q8LMtq8Uz6F7DsIbey2w1VBtOWk2UMxKHY6txqpw
	mQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4g4yfakh5v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 09:58:49 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936cadb0e8bso93632185a.0
        for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 06:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787147928; x=1787752728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8vRLr4hq/jt7Wt345UaSKOCc6NzvTZqNK8PhHqFZ8lk=;
        b=nrsMogrR5BUzt2ibVIoeedLag/1Yxx7P4VuLKWB9KNSZQRDmBm1pByIDxEHOPSpx/p
         6RaM5iaWP4fTVgikBzVEfm2CLYep/Xhsv/ZaUhugHupgERA5fyu5U6LIub+IczU2AvGc
         w/HuEpzaNp3vtaAy8vNvNa2lVKcMkaWUr36oNb28a7XW5m/lvCmgrXqw2w2sGzdvgkdY
         ZXR32yv7T0JE8omKCwYJvIikqew7uRsUl2yC1uBlIc3qpNLGdMhim2/HZuMa0QNUOI1c
         gZdB9Hbb6m8Jzrvisn6i9PhgZsbKaqJS8eIt/9lui66NHfLcgmHNVgmVSHoX7HXEJLxK
         yBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787147928; x=1787752728;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vRLr4hq/jt7Wt345UaSKOCc6NzvTZqNK8PhHqFZ8lk=;
        b=UbvQNeKzRkIjgfOUOM5Ayf0T/DkfFL0Bt0TYGMByzG4o8f4JFPt3aGdYzp+H/Z7evg
         sWTKISkeY/J0CB+YQXBv50/CVM6HMo3iWfAjk9m/yePWOyFT+W00bUEkQ+Tq0VjhjS1f
         TjxCM+IeQYDWGv9I7Kf0flb1f5vXOE8D5R1xXQHL6/5eVxzACO44lzoIOO+6/Pc4vyZW
         n3HeJ4fc+Fq3koYW0blVUdm4uxDBd3CKLiQqmKUYHWFUbNpGkIU53gImyZkmmucYKBAP
         94x4bJtUKlXm1B7CCP97t3/CAknX0EVfsSx5CgzMkSjJKuvDFftQ4IR3bBYU1gz3vebL
         y1uw==
X-Gm-Message-State: AOJu0YyxaLlOL6S1ykPyALKgcil0e9y2EoEZV/WU3xtFjvA9SA+elkNh
	SKx9nKh/IcvYoQChm+XD04M9Q5ThcaggodNMjGuL/SV4exNjXT6Kpu7G92oL0p0gzaRyANDKwGL
	Ka2dsm5sbm8g52HeKBXB7TQt+EzmamiAf47Vmt/RAy1/AF98HYkiMCjWOvXk=
X-Gm-Gg: AR+sD10EVllxlwLy8lKFDtmvxg6GL6hAI95gg475mZsAXWEceMLxe/I5sXijK6kWJqX
	oeXJlXSfhPPh5OucBr8fF25wysLKUrGyZ6dWwy+PVSpBcG9NmZsayRWnPWNbti3ipsJsWXhhmou
	8tE46woC2Xeh0ta9i9c0BDux7WXOjWJjV+2RJEEBZpNahpmtHCFZILqyxT+humlbrZmeVst2CRM
	VGhmvR0Seq7BuweM6vVE5ynqiUEWON/gwCj+c1oin5uI3h25w/SzjnQjlpSjtWva+EJt9+iDbXm
	NwlrJDEpy7PbbaJXtPuusfYYDvGhB1LuWDKYqy8rz4rdSCsPz44rfX3G41MuTiu/fd3h6F9y8bK
	cBItBmRnAbjFKKWIqee7lZDrglL1ufFeXodFAvpnTUsFKHdH263ZSuujyuF1jR8v4
X-Received: by 2002:a05:620a:170a:b0:92f:40d:6556 with SMTP id af79cd13be357-9371e316a79mr403968085a.18.1787147928220;
        Wed, 19 Aug 2026 06:58:48 -0700 (PDT)
X-Received: by 2002:a05:620a:170a:b0:92f:40d:6556 with SMTP id af79cd13be357-9371e316a79mr403962385a.18.1787147927612;
        Wed, 19 Aug 2026 06:58:47 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:782e:9cd5:4094:6d4f:9d51? ([2a00:a040:199:782e:9cd5:4094:6d4f:9d51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b802dsm5264531f8f.17.2026.08.19.06.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 06:58:46 -0700 (PDT)
Message-ID: <8acc54aa-1195-4b56-85b9-aaa0f582c628@columbia.edu>
Date: Wed, 19 Aug 2026 16:58:44 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,0/10] ceph: convert writeback path to folios
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
References: <<20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>
 <20260819110718.1304071-1-amarkuze@redhat.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260819110718.1304071-1-amarkuze@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwOCBTYWx0ZWRfXwJoywOohupOT
 LSNhS0HS0re5uzq9z5CZ1dIRue8U+vCVVPuVLPW9DndImf3IGVo5d3qWcmBC8rGINVgtYlQzTY9
 wm9NOGcEoNaWHQ/ZHpNwBNS7dsw/OuoLlZ0tP5+KQ2qe0qCn+vnlGCA5noI/hO5wFWiQd9Rkm17
 H5Qh75TjJyioszrtT5S9kdDC41EhVIESivpmTel9AvChUEmPtERlpm/qMHccFdUfhi64k35wBEq
 VbavsZ17PZS7wHdGkf8eUIFrBYQmroVH5f56bXREFxFfteD1NhphPjvUQ+2DsOiO5itI9oW7sIB
 8MmWsGZ3wcXGuxEIS0BrKNV4szygHOfSiX+EU73F/nmdCUqN8Fc67vBXIK7zn8xtS7G3RkwYP0C
 8iW4pt6M70Ysv4afdn11Gf3yPxKjoEMl0aqpS64FkQtXY7LRTzMjfWmrX+QA435z2RbB1m0kBpR
 HvqbY8XGHuV7wY+vafg==
X-Authority-Analysis: v=2.4 cv=L7ktheT8 c=1 sm=1 tr=0 ts=6a85b699 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=20KFwNOVAAAA:8 a=AYggDVvlHkniKv6gPEQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kTc7bTxnTDcA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: -Fhr4Ysm0XNGQ6DQKbGzX_xO8uIbbDsG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwOCBTYWx0ZWRfXy+8QzTl6Y5dM
 W1zvjyW7WCPHqwl1IGIWf8FA/logILsE8Bq05iuaRTiuijDicUlkBuxBV56bmXUlV9ncO/ae6EL
 NE10hggHPeqCD2BV++mp/szHqqbqiKFPZhT6tyP9X96+88A0Al07
X-Proofpoint-GUID: -Fhr4Ysm0XNGQ6DQKbGzX_xO8uIbbDsG
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11880
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=10
 suspectscore=0 bulkscore=10 clxscore=1015 spamscore=0 lowpriorityscore=10
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190108

On 8/19/26 7:07 AM, Alex Markuze wrote:
> Hi Tal,
> 
> Thanks for splitting it up — the ceph-only conversion looks good.
> 
> Reviewed-by: Alex Markuze <amarkuze@redhat.com>
> 

Thanks Alex!
